extends ScrollContainer

export var card_scale: float = 0.5 setget set_cards_scale

signal card_clicked(id)

var deck_list = DeckList.new()
var CardControl = preload("res://scenes/CardControl.tscn")
onready var grid = $margin/grid

func _ready() -> void:
	deck_list.write()
	var cards = deck_list.cards.keys().duplicate()
	cards.sort_custom(CardSorter.new(), "type")
	for id in cards:
		var card = deck_list.cards[id]
		var card_node = CardControl.instance()
		card_node.name = "card_%d" % id
		grid.add_child(card_node)
		card_node.get_node("viewport/card").setup_preview(card)
		card_node.card_scale = card_scale
		card_node.connect("clicked", self, "_on_click_card", [id])

func sort(sort_by: String):
	var cards = deck_list.cards.keys().duplicate()
	cards.sort_custom(CardSorter.new(), sort_by)
	for id in cards:
		var card_node = grid.get_node("card_%d" % id)
		card_node.raise()

func set_cards_scale(scale: float):
	for card in grid.get_children():
		card.card_scale = scale

func _on_click_card(id: int):
	emit_signal("card_clicked", id)

class CardSorter:
	var deck_list = DeckList.new()

	func type(key_a, key_b):
		var a = deck_list.cards[key_a]
		var b = deck_list.cards[key_b]
		if a.type == b.type:
			return a.name < b.name
		return a.type < b.type

	func rarity(key_a, key_b):
		var a = deck_list.cards[key_a]
		var b = deck_list.cards[key_b]
		if a.rarity == b.rarity:
			return a.name < b.name
		return a.rarity < b.rarity

	func extension(key_a, key_b):
		var a = deck_list.cards[key_a]
		var b = deck_list.cards[key_b]
		if a.extension == b.extension:
			return a.name < b.name
		return a.extension < b.extension

	func name(key_a, key_b):
		var a = deck_list.cards[key_a]
		var b = deck_list.cards[key_b]
		return a.name < b.name
