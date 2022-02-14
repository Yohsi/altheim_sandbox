extends Control

var decks: DeckList
var index = null
var deck_names = []
var deck_index = null

var CardEntry = preload("res://scenes/CardEntry.tscn")

func save_card() -> bool:
	if index == null:
		return false
	var type = CardType.from_str($content/workspace/editor/grid/type/edit.text)

	if (type == null):
		return false
	var card = {
		"name": $content/workspace/editor/grid/name/edit.text,
		"atk": int($content/workspace/editor/grid/attack/edit.text),
		"def": int($content/workspace/editor/grid/defense/edit.text),
		"description": $content/workspace/editor/description/edit.text,
		"subtypes": $content/workspace/editor/grid/subtype/edit.text,
		"constraints": $content/workspace/editor/grid/constraints/edit.text,
		"type": type,
		"color": $content/workspace/preview/color_picker.color
	}
	decks.default()[index] = card
	$content/workspace/preview/margins/preview.card = card
	return true

func change_card(new_index: int) -> void:
	save_card()
	if index != null:
		var old = get_node("content/side_panels/cards/scroll/list/card_entry_%d/name" % index)
		old.set("custom_colors/font_color", Color.white)
	index = new_index
	var new = get_node("content/side_panels/cards/scroll/list/card_entry_%d/name" % index)
	new.set("custom_colors/font_color", Color.darkorange)
	load_card()

func change_deck(new_index: int) -> void:
	save_card()
	if deck_index != null:
		var old = get_node("content/side_panels/decks/scroll/list/deck_entry_%d/name" % deck_index)
		old.set("custom_colors/font_color", Color.white)
	deck_index = new_index
	var new = get_node("content/side_panels/decks/scroll/list/deck_entry_%d/name" % deck_index)
	new.set("custom_colors/font_color", Color.darkorange)
	$content/side_panels/decks/name.text = deck_names[new_index]
	decks.default_deck = deck_names[new_index]
	index = null
	load_deck()

func load_card() -> void:
	if index == null:
		clear_card()
		return
	var card = decks.default()[index]
	$content/workspace/editor/grid/name/edit.text = card.name
	$content/workspace/editor/grid/type/edit.text = CardType.to_str(card.type)
	$content/workspace/editor/grid/subtype/edit.text = card.subtypes
	$content/workspace/editor/grid/attack/edit.text = str(card.atk)
	$content/workspace/editor/grid/defense/edit.text = str(card.def)
	$content/workspace/editor/grid/constraints/edit.text = str(card.constraints)
	$content/workspace/editor/description/edit.text = card.description
	$content/workspace/preview/margins/preview.card = card
	$content/workspace/preview/color_picker.color = card.color

func clear_card() -> void:
	$content/workspace/editor/grid/name/edit.text = ""
	$content/workspace/editor/grid/type/edit.text = ""
	$content/workspace/editor/grid/subtype/edit.text = ""
	$content/workspace/editor/grid/attack/edit.text = ""
	$content/workspace/editor/grid/defense/edit.text = ""
	$content/workspace/editor/grid/constraints/edit.text = ""
	$content/workspace/editor/description/edit.text = ""
	$content/workspace/preview/color_picker.color = Color.white

func back_btn_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func save():
	save_card()
	decks.write()
	load_deck()

func add_deck() -> void:
	var i = 1
	while decks.decks.has("deck%d"%i):
		i += 1
	decks.decks["deck%d"%i] = []
	decks.default_deck = "deck%d"%i
	load_decks()

func add_card() -> void:
	decks.default().append({
		"name": "",
		"atk": 0,
		"def": 0,
		"description": "",
		"subtypes": "",
		"constraints": "",
		"type": CardType.Creature,
		"color": DeckList.get_default_color(CardType.Creature)
	})
	load_deck()


func duplicate_card(i) -> void:
	var deck := decks.default()
	deck.insert(i+1, deck[i])
	load_deck()

func duplicate_deck(i) -> void:
	var name: String = deck_names[i]
	var name_strip: String = name
	while not name_strip.empty() and String(name_strip[len(name_strip)-1]).is_valid_integer():
		name_strip = name_strip.left(len(name_strip)-1)

	var n = 2
	while decks.decks.has("%s%d" % [name_strip, n]):
		n += 1
	decks.decks["%s%d" % [name_strip, n]] = decks.decks[name].duplicate(true)
	load_decks()


func remove_card(i) -> void:
	var deck := decks.default()
	deck.remove(i)
	if index != null && index >= i and len(deck) > 0:
		index -=1
	if index != null && index == -1:
		index = null
	load_deck()

func remove_deck(i) -> void:
	decks.decks.erase(deck_names[i])
	deck_names.remove(i)
	if deck_index == i:
		index = null
		if len(decks.decks) == 0:
			decks.default_deck = ""
			deck_index = null
		else:
			deck_index = max(0, deck_index - 1)
			decks.default_deck = deck_names[deck_index]
	if deck_index != null && deck_index > i and len(deck_names) > 0:
		deck_index -=1
	if deck_index != null && deck_index == -1:
		deck_index = null
	load_decks()


func load_deck() -> void:
	Util.delete_children($content/side_panels/cards/scroll/list)
	var i := 0
	for c in decks.default():
		var card_entry = CardEntry.instance()
		$content/side_panels/cards/scroll/list.add_child(card_entry)
		card_entry.name = "card_entry_%d" % i
		card_entry.get_node("name").text = c.name
		card_entry.get_node("name").connect("pressed", self, "change_card", [i])
		card_entry.get_node("remove_container/remove").connect("pressed", self, "remove_card", [i])
		card_entry.get_node("duplicate_container/duplicate").connect("pressed", self, "duplicate_card", [i])
		i += 1
	if index != null and index >= i:
		index = null
	load_card()
	$content/side_panels/cards/title.text = "Cartes (%d)" % len(decks.default())

func load_decks() -> void:
	Util.delete_children($content/side_panels/decks/scroll/list)
	deck_names.clear()
	var i := 0
	for name in decks.decks:
		deck_names.append(name)
		var deck_entry = CardEntry.instance()
		$content/side_panels/decks/scroll/list.add_child(deck_entry)
		deck_entry.name = "deck_entry_%d" % i
		deck_entry.get_node("name").text = name
		deck_entry.get_node("name").connect("pressed", self, "change_deck", [i])
		deck_entry.get_node("remove_container/remove").connect("pressed", self, "remove_deck", [i])
		deck_entry.get_node("duplicate_container/duplicate").connect("pressed", self, "duplicate_deck", [i])
		if decks.default_deck == name:
			deck_index = i
			deck_entry.get_node("name").set("custom_colors/font_color", Color.darkorange)
			$content/side_panels/decks/name.text = name
		i += 1
	if deck_index != null and deck_index >= i:
		deck_index = null
	else:
		load_deck()

func rename_deck():
	if deck_index == null:
		return
	var new_name : String = $content/side_panels/decks/name.text
	if decks.decks.has(new_name):
		return
	var current_deck_name = deck_names[deck_index]
	decks.decks[new_name] = decks.default()
	decks.default_deck = new_name
	deck_names[deck_index] = new_name
	decks.decks.erase(current_deck_name)
	var node = get_node("content/side_panels/decks/scroll/list/deck_entry_%d/name" % deck_index)
	node.text = new_name

func color_changed(color: Color):
	if index == null:
		return
	$content/workspace/preview/margins/preview/card/front/background.color = color

func name_changed(new_name):
	if index == null:
		return
	$content/side_panels/cards/scroll/list.get_child(index).get_node("name").text = new_name

static func open_file():
	OS.shell_open(ProjectSettings.globalize_path(DeckList.PATH))

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func _ready() -> void:
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$header/save_btn.connect("pressed", self, "save")
	$header/open_file.connect("pressed", self, "open_file")
	$content/side_panels/cards/add.connect("pressed", self, "add_card")
	$content/side_panels/decks/add.connect("pressed", self, "add_deck")
	$content/workspace/preview/margins/preview.setup(null, CardView.VisibleBy.BOTH, true)
	$content/side_panels/decks/rename.connect("pressed", self, "rename_deck")
	$content/workspace/preview/color_picker.connect("color_changed", self, "color_changed")
	$content/workspace/preview/color_picker.get_picker().hsv_mode = true
	$content/workspace/editor/grid/name/edit.connect("text_changed", self, "name_changed")
	decks = DeckList.new()
	load_decks()

func _exit_tree() -> void:
	save()
