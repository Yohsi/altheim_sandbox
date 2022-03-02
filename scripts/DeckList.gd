class_name DeckList

var config := ConfigFile.new()

var decks := {}
var default_deck : String

const PATH := "user://deck.cfg"

func _init() -> void:
	if config.load(PATH) != OK:
		create_default_config()
	else:
		load_cfg()
		if decks.empty():
			create_default_config()
			config.load(PATH)
			load_cfg()
		if not decks.has(default_deck):
			default_deck = decks.keys()[0]


static func get_default_color(type):
	match type:
		CardType.Creature:
			return Color.khaki
		CardType.Construction:
			return Color.lightsteelblue
		CardType.Place:
			return Color.palegreen
		CardType.Divinity:
			return Color.lightskyblue
		CardType.Miracle:
			return Color.lightsalmon

func load_cfg():
	decks.clear()
	default_deck = config.get_value("config", "default_deck", "")
	for id in config.get_sections():
		if id != "config":
			var name = config.get_value(id, "name")
			var deck = config.get_value(id, "cards")
			decks[name] = deck
			for card in deck:
				if not card.has("color"):
					card["color"] = get_default_color(card.type)


func write() -> void:
	config.clear()
	config.set_value("config", "default_deck", default_deck)
	var i := 1
	for name in decks:
		var id := "deck%d" % i
		var deck = decks[name]
		config.set_value(id, "name", name)
		config.set_value(id, "cards", deck)
		i += 1
	config.save(PATH)

func default() -> Array:
	if decks.empty():
		return []
	return decks[default_deck]

func create_default_config():
	var dir = Directory.new()
	dir.copy("res://scripts/default_decks.cfg", PATH)

