extends Control

var deck_list: DeckList = DeckList.new()
var current_deck = null

onready var deck_list_node = $content/left/decks/scroll/list
onready var add_deck_btn_node = $content/left/decks/add
onready var deck_name_node = $content/left/deck/title
onready var card_list_node = $content/left/deck/scroll/list
onready var name_edit_node = $content/left/deck/name_edit
onready var rename_btn_node = $content/left/deck/rename

var CardEntry = preload("res://scenes/CardEntry.tscn")
var ClickableEntry = preload("res://scenes/ClickableEntry.tscn")


func back_btn_pressed():
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")


func save():
	deck_list.write()
	load_deck()


func add_deck() -> void:
	var i = 1
	while deck_list.decks.has("deck%d"%i):
		i += 1
	deck_list.decks["deck%d"%i] = {}
	load_decks()


func add_card(id, nb) -> void:
	if current_deck == null:
		return
	var deck :Dictionary = deck_list.decks[current_deck]
	if not deck.has(id):
		deck[id] = nb
	else:
		deck[id] += nb
	if deck[id] <= 0:
		deck.erase(id)
	load_deck()


func duplicate_deck(name) -> void:
	var name_strip: String = name
	while not name_strip.empty() and String(name_strip[len(name_strip)-1]).is_valid_integer():
		name_strip = name_strip.left(len(name_strip)-1)

	var n = 2
	while deck_list.decks.has("%s%d" % [name_strip, n]):
		n += 1
	deck_list.decks["%s%d" % [name_strip, n]] = deck_list.decks[name].duplicate(true)
	load_decks()


func remove_deck(name: String) -> void:
	deck_list.decks.erase(name)
	if current_deck == name:
		current_deck = null
	load_decks()


func change_deck(new_name: String) -> void:
	if current_deck != null:
		var old = deck_list_node.get_node("%s/name" % current_deck)
		Util.set_font_color(old, Color.white)
	current_deck = new_name
	var new = deck_list_node.get_node("%s/name" % current_deck)
	Util.set_font_color(new, Color.darkorange)
	load_deck()


func load_deck() -> void:
	Util.delete_children(card_list_node)
	if current_deck == null:
		deck_name_node.text = "Aucun deck sélectionné"
		name_edit_node.text = ""
		return
	var deck = deck_list.decks[current_deck]
	for id in deck:
		var card = deck_list.cards[id]
		var card_entry = CardEntry.instance()
		card_list_node.add_child(card_entry)
		card_entry.name = "card_entry_%d" % id
		var entry_name = card_entry.get_node("name")
		entry_name.text = "%s (%d)" % [card.name, deck[id]]
		entry_name.connect("pressed", self, "card_entry_pressed", [id])
		card_entry.get_node("add_container/add").connect("pressed", self, "add_card", [id, 1])
		card_entry.get_node("remove_container/remove").connect("pressed", self, "add_card", [id, -1])
	deck_name_node.text = "%s (%d)" % [current_deck, deck_list.deck_length(current_deck)]
	name_edit_node.text = current_deck

func card_entry_pressed(id):
	var scroll = $content/collection_view/collection
	var card = scroll.get_node("margin/grid/card_%d" % id)
	scroll.ensure_control_visible(card)
	card.play_focus_animation()

func load_decks() -> void:
	Util.delete_children(deck_list_node)
	var current_deck_exists = false
	var decks = deck_list.decks.keys()
	decks.sort()
	for name in decks:
		var deck_entry = ClickableEntry.instance()
		deck_list_node.add_child(deck_entry)
		deck_entry.name = name
		deck_entry.get_node("name").text = name
		deck_entry.get_node("name").connect("pressed", self, "change_deck", [name])
		deck_entry.get_node("remove_container/remove").connect("pressed", self, "remove_deck", [name])
		deck_entry.get_node("duplicate_container/duplicate").connect("pressed", self, "duplicate_deck", [name])
		if current_deck == name:
			deck_entry.get_node("name").set("custom_colors/font_color", Color.darkorange)
			current_deck_exists = true
	if not current_deck_exists:
		current_deck = null
	load_deck()


func rename_deck(new_name = name_edit_node.text):
	if current_deck == null:
		return

	if deck_list.decks.has(new_name) or new_name.empty():
		name_edit_node.set("custom_colors/font_color", Color.red)
		return
	name_edit_node.set("custom_colors/font_color", Color.white)

	deck_list.decks[new_name] = deck_list.decks[current_deck]
	deck_list.decks.erase(current_deck)

	if deck_list.default_deck == current_deck:
		deck_list.default_deck = new_name

	current_deck = new_name
	load_decks()


static func open_file():
	DeckList.open_file()

func edit_card(id):
	var scene = load("res://scenes/CardEditor.tscn").instance()
	scene.current_card_id = id
	var root = get_tree().get_root()
	Util.delete_children(root)
	root.add_child(scene)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()


func _ready() -> void:
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$header/save_btn.connect("pressed", self, "save")
	$header/open_file.connect("pressed", self, "open_file")
	add_deck_btn_node.connect("pressed", self, "add_deck")
	rename_btn_node.connect("pressed", self, "rename_deck")
	$content/collection_view.connect("card_clicked", self, "add_card", [1])
	$content/collection_view.connect("edit_card_clicked", self, "edit_card")
	load_decks()


func _exit_tree() -> void:
	save()
