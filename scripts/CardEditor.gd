extends Control

var deck_list: DeckList
var current_card_id = null

onready var name_node = $content/workspace/editor/grid/name/edit
onready var type_node = $content/workspace/editor/grid/type/edit
onready var subtype_node = $content/workspace/editor/grid/subtype/edit
onready var attack_node = $content/workspace/editor/grid/attack/edit
onready var defense_node = $content/workspace/editor/grid/defense/edit
onready var constraints_node = $content/workspace/editor/grid/constraints/edit
onready var description_node = $content/workspace/editor/description/edit
onready var rarity_node = $content/workspace/editor/grid/rarity/edit
onready var extension_node = $content/workspace/editor/grid/extension/edit
onready var devotions_node = $content/workspace/editor/grid/devotions/edit
onready var preview_node = $content/workspace/preview/margins/preview
onready var color_picker_node = $content/workspace/preview/color_picker
onready var card_list_node = $content/cards/scroll/list
onready var sort_mode_node = $content/cards/sort_mode/sort_mode

var ClickableEntry = preload("res://scenes/ClickableEntry.tscn")

func save_card() -> bool:
	if current_card_id == null:
		return false

	var type_idx = type_node.get_selected_id()
	var type = CardType.from_str(type_node.get_item_text(type_idx))
	if (type == null):
		return false

	var rar_idx = rarity_node.get_selected_id()
	var rarity = CardRarity.from_str(rarity_node.get_item_text(rar_idx))
	if (rarity == null):
		return false

	var card = {
		"name": name_node.text,
		"atk": int(attack_node.text),
		"def": int(defense_node.text),
		"description": description_node.text,
		"subtypes": subtype_node.text,
		"constraints": constraints_node.text,
		"type": type,
		"color": color_picker_node.color,
		"rarity": rarity,
		"extension": extension_node.text,
		"devotions": devotions_node.text
	}
	deck_list.cards[current_card_id] = card
	preview_node.card = card
	return true

func change_card(new_id: int) -> void:
	save_card()
	if current_card_id != null:
		var old = card_list_node.get_node("card_entry_%d/name" % current_card_id)
		var color = CardType.color_of(deck_list.cards[current_card_id].type)
		Util.set_font_color(old, color)
	current_card_id = new_id
	var new = card_list_node.get_node("card_entry_%d/name" % current_card_id)
	Util.set_font_color(new, Color.white)
	load_card()


func load_card() -> void:
	if current_card_id == null:
		clear_card()
		return
	var card = deck_list.cards[current_card_id]
	name_node.text = card.name
	for idx in type_node.get_item_count():
		if type_node.get_item_text(idx) == CardType.to_str(card.type):
			type_node.select(idx)
	for idx in rarity_node.get_item_count():
		if rarity_node.get_item_text(idx) == CardRarity.to_str(card.rarity):
			rarity_node.select(idx)
	subtype_node.text = card.subtypes
	attack_node.text = str(card.atk)
	defense_node.text = str(card.def)
	constraints_node.text = str(card.constraints)
	description_node.text = card.description
	preview_node.card = card
	color_picker_node.color = card.color
	extension_node.text = card.extension
	devotions_node.text = card.devotions

func clear_card() -> void:
	name_node.text = ""
	type_node.select(0)
	rarity_node.select(0)
	subtype_node.text = ""
	attack_node.text = ""
	defense_node.text = ""
	constraints_node.text = ""
	description_node.text = ""
	color_picker_node.color = Color.white
	extension_node.text = ""
	devotions_node.text = ""

func back_btn_pressed():
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")

func save():
	save_card()
	deck_list.write()
	load_card_list()

func add_card() -> void:
	var new_id = deck_list.add_card({
		"name": "",
		"atk": 0,
		"def": 0,
		"description": "",
		"subtypes": "",
		"constraints": "",
		"rarity": CardRarity.BANAL,
		"type": CardType.Creature,
		"color": CardType.color_of(CardType.Creature),
		"devotions": "",
		"extension": "Base",
	})
	load_card_list()
	change_card(new_id)


func duplicate_card(i) -> void:
	deck_list.add_card(deck_list.cards[i].duplicate())
	load_card_list()


func remove_card(i) -> void:
	deck_list.cards.erase(i)
	if current_card_id == i:
		current_card_id = null
	load_card_list()


func load_card_list() -> void:
	Util.delete_children(card_list_node)
	var keep_selected = false

	var cards = deck_list.cards.keys().duplicate()
	cards.sort_custom(Util.CardSorter.new(deck_list.cards), sort_mode_node.get_selected_metadata())

	for id in cards:
		var card = deck_list.cards[id]
		if id == current_card_id:
			keep_selected = true
		var card_entry = ClickableEntry.instance()
		card_list_node.add_child(card_entry)
		card_entry.name = "card_entry_%d" % id
		var name = card_entry.get_node("name")
		name.text = card.name
		name.connect("pressed", self, "change_card", [id])
		var color = CardType.color_of(card.type)
		Util.set_font_color(name, color)
		card_entry.get_node("remove_container/remove").connect("pressed", self, "remove_card", [id])
		card_entry.get_node("duplicate_container/duplicate").connect("pressed", self, "duplicate_card", [id])

	if not keep_selected:
		current_card_id = null

	load_card()
	$content/cards/title.text = "Cartes (%d)" % len(deck_list.cards)

func color_changed(color: Color):
	if current_card_id == null:
		return
	preview_node.get_node("card/front/background").color = color

func name_changed(new_name):
	if current_card_id == null:
		return
	update_preview()
	card_list_node.get_node("card_entry_%d" % current_card_id).get_node("name").text = new_name

func open_file():
	DeckList.open_file()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func _ready() -> void:
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$header/save_btn.connect("pressed", self, "save")
	$header/open_file.connect("pressed", self, "open_file")
	$content/cards/add.connect("pressed", self, "add_card")
	preview_node.setup_preview(null)
	color_picker_node.connect("color_changed", self, "color_changed")
	color_picker_node.get_picker().hsv_mode = true
	name_node.connect("text_changed", self, "name_changed")
	type_node.connect("item_selected", self, "type_changed")
	deck_list = DeckList.new()

	sort_mode_node.add_item("Type", 0)
	sort_mode_node.set_item_metadata(0, "type")
	sort_mode_node.add_item("Nom", 1)
	sort_mode_node.set_item_metadata(1, "name")
	sort_mode_node.add_item("Rareté", 2)
	sort_mode_node.set_item_metadata(2, "rarity")
	sort_mode_node.add_item("Extension", 3)
	sort_mode_node.set_item_metadata(3, "extension")
	sort_mode_node.connect("item_selected", self, "on_sort_changed")
	load_card_list()

func on_sort_changed(_index):
	load_card_list()

func type_changed(index):
	save_card()
	var type = CardType.from_str(type_node.get_item_text(index))
	update_preview()
	var color = CardType.color_of(type)
	color_picker_node.color = color
	color_changed(color)

func update_preview():
	if current_card_id == null:
		return
	preview_node.card = deck_list.cards[current_card_id]

func _exit_tree() -> void:
	save()
