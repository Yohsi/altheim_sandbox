class_name Util

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

static func set_font_color(node, color):
	node.set("custom_colors/font_color", color)
	node.set("custom_colors/font_color_focus", color)
	node.set("custom_colors/font_color_hover", color)
	node.set("custom_colors/font_color_pressed", color)

class CardSorter:
	var cards

	func _init(p_cards):
		self.cards = p_cards

	func type(key_a, key_b):
		var a = cards[key_a]
		var b = cards[key_b]
		if a.type == b.type:
			return a.name < b.name
		return a.type < b.type

	func rarity(key_a, key_b):
		var a = cards[key_a]
		var b = cards[key_b]
		if a.rarity == b.rarity:
			return a.name < b.name
		return a.rarity < b.rarity

	func extension(key_a, key_b):
		var a = cards[key_a]
		var b = cards[key_b]
		if a.extension == b.extension:
			return a.name < b.name
		return a.extension < b.extension

	func name(key_a, key_b):
		var a = cards[key_a]
		var b = cards[key_b]
		return a.name < b.name
