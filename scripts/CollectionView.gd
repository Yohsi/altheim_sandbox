extends VBoxContainer

export var card_scale: float = 0.5 setget set_cards_scale

signal card_clicked(id)
signal edit_card_clicked(id)

var deck_list = DeckList.new()
var CardControl = preload("res://scenes/CardControl.tscn")
onready var grid = $collection/margin/grid
onready var size_slider = $options/size_slider
onready var sort_mode = $options/sort_mode

func _ready() -> void:
	sort_mode.add_item("Type", 0)
	sort_mode.set_item_metadata(0, "type")
	sort_mode.add_item("Nom", 1)
	sort_mode.set_item_metadata(1, "name")
	sort_mode.add_item("Rareté", 2)
	sort_mode.set_item_metadata(2, "rarity")
	sort_mode.add_item("Extension", 3)
	sort_mode.set_item_metadata(3, "extension")
	sort_mode.connect("item_selected", self, "on_sort_changed")

	var cards = deck_list.cards.keys().duplicate()
	cards.sort_custom(Util.CardSorter.new(deck_list.cards), sort_mode.get_selected_metadata())
	for id in cards:
		var card = deck_list.cards[id]
		var card_node = CardControl.instance()
		card_node.name = "card_%d" % id
		grid.add_child(card_node)
		card_node.get_node("viewport/card").setup_preview(card)
		card_node.card_scale = card_scale
		card_node.connect("clicked", self, "_on_click_card", [id])
		card_node.connect("edit_clicked", self, "_on_edit_click_card", [id])

	set_cards_scale(size_slider.value)
	size_slider.connect("value_changed", self, "set_cards_scale")

func on_sort_changed(_index):
	sort(sort_mode.get_selected_metadata())

func sort(sort_by: String):
	var cards = deck_list.cards.keys().duplicate()
	cards.sort_custom(Util.CardSorter.new(deck_list.cards), sort_by)
	for id in cards:
		var card_node = grid.get_node("card_%d" % id)
		card_node.raise()

func set_cards_scale(scale: float):
	for card in grid.get_children():
		card.card_scale = scale

func _on_click_card(id: int):
	emit_signal("card_clicked", id)

func _on_edit_click_card(id: int):
	emit_signal("edit_card_clicked", id)
