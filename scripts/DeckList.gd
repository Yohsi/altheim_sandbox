class_name DeckList

var config := ConfigFile.new()

# id -> card
var cards := {}

# name -> {card id -> nb}
var decks := {}

# name of the default deck
var default_deck : String

const OLD_PATH := "user://deck.cfg"
const NEW_PATH := "user://decks.cfg"

func _init() -> void:
	var old_path = ProjectSettings.globalize_path(OLD_PATH)
	var new_path = ProjectSettings.globalize_path(NEW_PATH)

	print("Trying to open new config file at %s" % new_path)
	if config.load(NEW_PATH) == OK:
		print("Success")
		load_cfg()
	else:
		print("Fail")
		print("Trying to open old config file at %s" % old_path)
		if config.load(OLD_PATH) == OK:
			print("Success")
			load_old_cfg()
		else:
			print("Fail")
			create_default_config()

func add_card(card):
	var new_id = 0
	while cards.has(new_id):
		new_id += 1
	cards[new_id] = card
	return new_id


func load_cfg():
	default_deck = config.get_value("decks", "default_deck", "")
	cards = config.get_value("decks", "cards", "")
	decks = config.get_value("decks", "decks", "")


func write() -> void:
	config.clear()
	config.set_value("decks", "default_deck", default_deck)
	config.set_value("decks", "cards", cards)
	config.set_value("decks", "decks", decks)
	var new_path = ProjectSettings.globalize_path(NEW_PATH)
	print("writing config file to %s" % new_path)
	config.save(NEW_PATH)


static func open_file():
	var path = ProjectSettings.globalize_path(NEW_PATH)
	print("Opening config file at %s" % path)
	OS.shell_open(path)

func flatten_deck(name: String):
	var flat_deck = []
	var deck = decks[name]
	for id in deck:
		for i in deck[id]:
			flat_deck.append(cards[id].duplicate())
	return flat_deck

func default() -> Array:
	if decks.empty():
		return []
	if not decks.has(default_deck):
		default_deck = decks.keys().front()
	return decks[default_deck]

func create_default_config():
	var dir = Directory.new()
	dir.copy("res://scripts/default_decks.cfg", OLD_PATH)
	config.load(OLD_PATH)
	load_old_cfg()

func deck_length(name):
	var deck = decks[name]
	var sum = 0
	for id in deck:
		sum += deck[id]
	return sum

func load_old_cfg():
	default_deck = config.get_value("config", "default_deck", "")

	var old_decks = {}
	for id in config.get_sections():
		if id != "config":
			var name = config.get_value(id, "name")
			var deck = config.get_value(id, "cards")
			old_decks[name] = deck
			for card in deck:
				if not card.has("color"):
					card["color"] = CardType.color_of(card.type)
				if not card.has("rarity"):
					card["rarity"] = CardRarity.BANAL
				if not card.has("extension"):
					card["extension"] = "Base"
				if not card.has("devotions"):
					card["devotions"] = ""

	decks = {}
	cards = {}
	var id_by_name = {}
	var i = 0
	for deck_name in old_decks:
		var deck = old_decks[deck_name]
		decks[deck_name] = {}
		for card in deck:
			if card.name in id_by_name:
				var id = id_by_name[card.name]
				if not id in decks[deck_name]:
					decks[deck_name][id] = 0
				decks[deck_name][id] += 1
			else:
				id_by_name[card.name] = i
				cards[i] = card
				if not i in decks[deck_name]:
					decks[deck_name][i] = 0
				decks[deck_name][i] += 1
				i += 1
