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
	default_deck = config.get_value("config", "default_deck")
	for id in config.get_sections():
		if id != "config":
			var name = config.get_value(id, "name")
			var deck = config.get_value(id, "cards")
			decks[name] = deck
			for card in deck:
				if not card.has("color"):
					card["color"] = get_default_color(card.type)

	if decks.empty():
		create_default_config()
	if not decks.has(default_deck):
		default_deck = decks.keys()[0]

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
	default_deck = "Tribu des Plaines chamaniques (P) B"
	decks["Alliance de Galdim (F) B"] = [
		{
			"atk": 2,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Forêt",
			"def": 2,
			"description": "",
			"name": "Éclaireuse",
			"subtypes": "Satyre",
			"type": 1
			}, {
			"atk": 2,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Forêt",
			"def": 2,
			"description": "",
			"name": "Éclaireuse",
			"subtypes": "Satyre",
			"type": 1
			}, {
			"atk": 2,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Forêt",
			"def": 2,
			"description": "",
			"name": "Éclaireuse",
			"subtypes": "Satyre",
			"type": 1
			}, {
			"atk": 2,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Forêt",
			"def": 2,
			"description": "",
			"name": "Éclaireuse",
			"subtypes": "Satyre",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Forêts",
			"def": 0,
			"description": "La Créature bénie a +1 de Migration.",
			"name": "Course",
			"subtypes": "Bénédiction de Créature",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Forêts",
			"def": 0,
			"description": "La Créature bénie a +1 de Migration.",
			"name": "Course",
			"subtypes": "Bénédiction de Créature",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Forêts",
			"def": 0,
			"description": "La Créature bénie a +1 de Migration.",
			"name": "Course",
			"subtypes": "Bénédiction de Créature",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Forêts",
			"def": 0,
			"description": "La Créature bénie a +1 de Migration.",
			"name": "Course",
			"subtypes": "Bénédiction de Créature",
			"type": 2
			}, {
			"atk": 2,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "3 Forêts",
			"def": 4,
			"description": "Migration 2.",
			"name": "Ermite nomade",
			"subtypes": "Centaure",
			"type": 1
			}, {
			"atk": 2,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "3 Forêts",
			"def": 4,
			"description": "Migration 2.",
			"name": "Ermite nomade",
			"subtypes": "Centaure",
			"type": 1
			}, {
			"atk": 2,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "3 Forêts",
			"def": 4,
			"description": "Migration 2.",
			"name": "Ermite nomade",
			"subtypes": "Centaure",
			"type": 1
			}, {
			"atk": 2,
			"color": Color( 0.94, 0.9, 0.55,
			 1 ),
			"constraints": "3 Forêts",
			"def": 4,
			"description": "Migration 2.",
			"name": "Ermite nomade",
			"subtypes": "Centaure",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "5 Forêts",
			"def": 0,
			"description": "Vos Créatures qui migrent sur le Lieu béni ont +1/+1.",
			"name": "Source vitale",
			"subtypes": "Bénédiction de Lieu",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "5 Forêts",
			"def": 0,
			"description": "Vos Créatures qui migrent sur le Lieu béni ont +1/+1.",
			"name": "Source vitale",
			"subtypes": "Bénédiction de Lieu",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "5 Forêts",
			"def": 0,
			"description": "Vos Créatures qui migrent sur le Lieu béni ont +1/+1.",
			"name": "Source vitale",
			"subtypes": "Bénédiction de Lieu",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "5 Forêts",
			"def": 0,
			"description": "Vos Créatures qui migrent sur le Lieu béni ont +1/+1.",
			"name": "Source vitale",
			"subtypes": "Bénédiction de Lieu",
			"type": 2
			}, {
			"atk": 3,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "2 Forêts",
			"def": 3,
			"description": "Vos autres Créatures ont +1 de Migration.",
			"name": "Tisseur de vitalité",
			"subtypes": "Minotaure",
			"type": 1
			}, {
			"atk": 3,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "2 Forêts",
			"def": 3,
			"description": "Vos autres Créatures ont +1 de Migration.",
			"name": "Tisseur de vitalité",
			"subtypes": "Minotaure",
			"type": 1
			}, {
			"atk": 3,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "2 Forêts",
			"def": 3,
			"description": "Vos autres Créatures ont +1 de Migration.",
			"name": "Tisseur de vitalité",
			"subtypes": "Minotaure",
			"type": 1
			}, {
			"atk": 3,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "2 Forêts",
			"def": 3,
			"description": "Vos autres Créatures ont +1 de Migration.",
			"name": "Tisseur de vitalité",
			"subtypes": "Minotaure",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Forêts",
			"def": 0,
			"description": "Piochez 1 carte pour chacune de vos Créatures qui a migré ce tour-ci.",
			"name": "Exploration fructueuse",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Forêts",
			"def": 0,
			"description": "Piochez 1 carte pour chacune de vos Créatures qui a migré ce tour-ci.",
			"name": "Exploration fructueuse",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Forêts",
			"def": 0,
			"description": "Piochez 1 carte pour chacune de vos Créatures qui a migré ce tour-ci.",
			"name": "Exploration fructueuse",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Forêts",
			"def": 0,
			"description": "Piochez 1 carte pour chacune de vos Créatures qui a migré ce tour-ci.",
			"name": "Exploration fructueuse",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
			"constraints": "2 Forêts",
			"def": 5,
			"description": "Migration 0. Chaque fois qu'une de vos Créatures migre d'un Lieu, elle a +1/+1 jusqu'à la fin du tour.",
			"name": "Hêtre ancestral",
			"subtypes": "Arbre",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
			"constraints": "2 Forêts",
			"def": 5,
			"description": "Migration 0. Chaque fois qu'une de vos Créatures migre d'un Lieu, elle a +1/+1 jusqu'à la fin du tour.",
			"name": "Hêtre ancestral",
			"subtypes": "Arbre",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
			"constraints": "2 Forêts",
			"def": 5,
			"description": "Migration 0. Chaque fois qu'une de vos Créatures migre d'un Lieu, elle a +1/+1 jusqu'à la fin du tour.",
			"name": "Hêtre ancestral",
			"subtypes": "Arbre",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
			"constraints": "2 Forêts",
			"def": 5,
			"description": "Migration 0. Chaque fois qu'une de vos Créatures migre d'un Lieu, elle a +1/+1 jusqu'à la fin du tour.",
			"name": "Hêtre ancestral",
			"subtypes": "Arbre",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": " 4 Forêts",
			"def": 0,
			"description": "A la fin de votre tour, si le Lieu béni est visible, piochez 1 carte.",
			"name": "Nature immaculée",
			"subtypes": "Bénédiction de Lieu",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": " 4 Forêts",
			"def": 0,
			"description": "A la fin de votre tour, si le Lieu béni est visible, piochez 1 carte.",
			"name": "Nature immaculée",
			"subtypes": "Bénédiction de Lieu",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": " 4 Forêts",
			"def": 0,
			"description": "A la fin de votre tour, si le Lieu béni est visible, piochez 1 carte.",
			"name": "Nature immaculée",
			"subtypes": "Bénédiction de Lieu",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": " 4 Forêts",
			"def": 0,
			"description": "A la fin de votre tour, si le Lieu béni est visible, piochez 1 carte.",
			"name": "Nature immaculée",
			"subtypes": "Bénédiction de Lieu",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "1 Forêt",
			"def": 1,
			"description": "A la fin de votre tour, vos Créatures qui ont migré ont +1/+1.",
			"name": "Autel floral",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "1 Forêt",
			"def": 1,
			"description": "A la fin de votre tour, vos Créatures qui ont migré ont +1/+1.",
			"name": "Autel floral",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "1 Forêt",
			"def": 1,
			"description": "A la fin de votre tour, vos Créatures qui ont migré ont +1/+1.",
			"name": "Autel floral",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "1 Forêt",
			"def": 1,
			"description": "A la fin de votre tour, vos Créatures qui ont migré ont +1/+1.",
			"name": "Autel floral",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 5,
			"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
			"constraints": "5 Forêts",
			"def": 5,
			"description": "Chaque fois qu'il migre d'un Lieu, il a +1/+1.",
			"name": "Gardien de la hêtraie",
			"subtypes": "Sylvain",
			"type": 1
			}, {
			"atk": 5,
			"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
			"constraints": "5 Forêts",
			"def": 5,
			"description": "Chaque fois qu'il migre d'un Lieu, il a +1/+1.",
			"name": "Gardien de la hêtraie",
			"subtypes": "Sylvain",
			"type": 1
			}, {
			"atk": 5,
			"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
			"constraints": "5 Forêts",
			"def": 5,
			"description": "Chaque fois qu'il migre d'un Lieu, il a +1/+1.",
			"name": "Gardien de la hêtraie",
			"subtypes": "Sylvain",
			"type": 1
			}, {
			"atk": 5,
			"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
			"constraints": "5 Forêts",
			"def": 5,
			"description": "Chaque fois qu'il migre d'un Lieu, il a +1/+1.",
			"name": "Gardien de la hêtraie",
			"subtypes": "Sylvain",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "Vos Créatures qui migrent dessus peuvent migrer d'un Lieu de plus dans la même direction.",
			"name": "Pente forestière",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "Découverte : une de vos Créatures a +1 de Migration jusqu'à la fin du tour.",
			"name": "Clairière secrète",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Forêt",
			"subtypes": "Forêt",
			"type": 0
			}
	]

	var deck : = []
	deck.append({
		"name": "Gorlung Main rouge",
		"atk": 5,
		"def": 3,
		"description": "Quand vous l'invoquez, placez la Stèle de l'Alliance et Lithia Coeur Rouge dans votre Main depuis votre Deck",
		"subtypes": "Orc et Chef",
		"type": CardType.Creature,
		"constraints": "3 Plaines et 2 Lieux"
	})
	deck.append({
		"name": "Plaine",
		"atk": 0,
		"def": 0,
		"description": "",
		"subtypes": "",
		"type": CardType.Place,
		"constraints": ""
	})
	decks["Royaume de Sitgard (M) B"] = [
		{
			"atk": 1,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Montagne",
			"def": 3,
			"description": "",
			"name": "Fantassin",
			"subtypes": "Nain",
			"type": 1
			}, {
			"atk": 1,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Montagne",
			"def": 3,
			"description": "",
			"name": "Fantassin",
			"subtypes": "Nain",
			"type": 1
			}, {
			"atk": 1,
			"color": Color( 0.94, 0.9,
			 0.55, 1 ),
			"constraints": "1 Montagne",
			"def": 3,
			"description": "",
			"name": "Fantassin",
			"subtypes": "Nain",
			"type": 1
			}, {
			"atk": 1,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Montagne",
			"def": 3,
			"description": "",
			"name": "Fantassin",
			"subtypes": "Nain",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "3 Montagnes",
			"def": 8,
			"description": "",
			"name": "Rempart",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "3 Montagnes",
			"def": 8,
			"description": "",
			"name": "Rempart",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "3 Montagnes",
			"def": 8,
			"description": "",
			"name": "Rempart",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "3 Montagnes",
			"def": 8,
			"description": "",
			"name": "Rempart",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "2 Montagnes",
			"def": 0,
			"description": "Piochez 1 carte.",
			"name": "Runes",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "2 Montagnes",
			"def": 0,
			"description": "Piochez 1 carte.",
			"name": "Runes",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "2 Montagnes",
			"def": 0,
			"description": "Piochez 1 carte.",
			"name": "Runes",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "2 Montagnes",
			"def": 0,
			"description": "Piochez 1 carte.",
			"name": "Runes",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 1,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "2 Montagnes",
			"def": 4,
			"description": "Vos Constructions ont +1 de puissance quand elles défendent.",
			"name": "Garde en faction",
			"subtypes": "Nain",
			"type": 1
			}, {
			"atk": 1,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "2 Montagnes",
			"def": 4,
			"description": "Vos Constructions ont +1 de puissance quand elles défendent.",
			"name": "Garde en faction",
			"subtypes": "Nain",
			"type": 1
			}, {
			"atk": 1,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "2 Montagnes",
			"def": 4,
			"description": "Vos Constructions ont +1 de puissance quand elles défendent.",
			"name": "Garde en faction",
			"subtypes": "Nain",
			"type": 1
			}, {
			"atk": 1,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "2 Montagnes",
			"def": 4,
			"description": "Vos Constructions ont +1 de puissance quand elles défendent.",
			"name": "Garde en faction",
			"subtypes": "Nain",
			"type": 1
			}, {
			"atk": 2,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "3 Montagnes",
			"def": 6,
			"description": "",
			"name": "Avant-poste",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 2,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "3 Montagnes",
			"def": 6,
			"description": "",
			"name": "Avant-poste",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 2,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "3 Montagnes",
			"def": 6,
			"description": "",
			"name": "Avant-poste",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 2,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "3 Montagnes",
			"def": 6,
			"description": "",
			"name": "Avant-poste",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Montagnes",
			"def": 0,
			"description": "Détruisez une Créature.",
			"name": "Chute de pierres",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Montagnes",
			"def": 0,
			"description": "Détruisez une Créature.",
			"name": "Chute de pierres",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Montagnes",
			"def": 0,
			"description": "Détruisez une Créature.",
			"name": "Chute de pierres",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "3 Montagnes",
			"def": 0,
			"description": "Détruisez une Créature.",
			"name": "Chute de pierres",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Montagne",
			"def": 2,
			"description": "Invocation : piochez 1 carte.",
			"name": "Sage runique",
			"subtypes": "Nain - Mage",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Montagne",
			"def": 2,
			"description": "Invocation : piochez 1 carte.",
			"name": "Sage runique",
			"subtypes": "Nain - Mage",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Montagne",
			"def": 2,
			"description": "Invocation : piochez 1 carte.",
			"name": "Sage runique",
			"subtypes": "Nain - Mage",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.94, 0.9, 0.55, 1 ),
			"constraints": "1 Montagne",
			"def": 2,
			"description": "Invocation : piochez 1 carte.",
			"name": "Sage runique",
			"subtypes": "Nain - Mage",
			"type": 1
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "2 Montagnes",
			"def": 2,
			"description": "Quand elle est détruite par une Créature, détruisez cette Créature.",
			"name": "Galerie piégée",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "2 Montagnes",
			"def": 2,
			"description": "Quand elle est détruite par une Créature, détruisez cette Créature.",
			"name": "Galerie piégée",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "2 Montagnes",
			"def": 2,
			"description": "Quand elle est détruite par une Créature, détruisez cette Créature.",
			"name": "Galerie piégée",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "2 Montagnes",
			"def": 2,
			"description": "Quand elle est détruite par une Créature, détruisez cette Créature.",
			"name": "Galerie piégée",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "4 Montagnes",
			"def": 0,
			"description": "Détruisez une Construction.",
			"name": "Glissement de terrain",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "4 Montagnes",
			"def": 0,
			"description": "Détruisez une Construction.",
			"name": "Glissement de terrain",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "4 Montagnes",
			"def": 0,
			"description": "Détruisez une Construction.",
			"name": "Glissement de terrain",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 0,
			"color": Color( 1, 0.631373, 0.478431, 1 ),
			"constraints": "4 Montagnes",
			"def": 0,
			"description": "Détruisez une Construction.",
			"name": "Glissement de terrain",
			"subtypes": "Intervention",
			"type": 2
			}, {
			"atk": 2,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "6 Montagnes",
			"def": 10,
			"description": "Quand vous détruisez une Créature ou une Construction, elle a +1/+1.",
			"name": "Forteresse imprenable",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 2,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "6 Montagnes",
			"def": 10,
			"description": "Quand vous détruisez une Créature ou une Construction, elle a +1/+1.",
			"name": "Forteresse imprenable",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 2,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "6 Montagnes",
			"def": 10,
			"description": "Quand vous détruisez une Créature ou une Construction, elle a +1/+1.",
			"name": "Forteresse imprenable",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 2,
			"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
			"constraints": "6 Montagnes",
			"def": 10,
			"description": "Quand vous détruisez une Créature ou une Construction, elle a +1/+1.",
			"name": "Forteresse imprenable",
			"subtypes": "Édifice",
			"type": 4
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "Découverte : votre adversaire défausse 1 carte si elle est sur l'une des deux premières lignes, sinon c'est vous qui défaussez 1 carte.",
			"name": "Corniche instable",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "Vos Entités dessus ne peuvent pas être attaquées par des Créatures avec plus de 5 de puissance.",
			"name": "Gorge resserrée",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type":
			 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			}, {
			"atk": 0,
			"color": Color( 0.6, 0.980392, 0.6, 1 ),
			"constraints": "",
			"def": 0,
			"description": "",
			"name": "Montagne",
			"subtypes": "Montagne",
			"type": 0
			} ]
	decks["Tribu des Plaines chamaniques (P) B"] = [ {
		"atk": 3,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "",
		"name": "Guerrière",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 3,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "",
		"name": "Guerrière",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 3,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "",
		"name": "Guerrière",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 3,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "",
		"name": "Guerrière",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Créature",
		"def": 0,
		"description": "À la fin de votre tour, la Créature maudite subit 1 blessure.",
		"name": "Saignement",
		"subtypes": "Malédiction de Créature",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Créature",
		"def": 0,
		"description": "À la fin de votre tour, la Créature maudite subit 1 blessure.",
		"name": "Saignement",
		"subtypes": "Malédiction de Créature",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Créature",
		"def": 0,
		"description": "À la fin de votre tour, la Créature maudite subit 1 blessure.",
		"name": "Saignement",
		"subtypes": "Malédiction de Créature",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Créature",
		"def": 0,
		"description": "À la fin de votre tour, la Créature maudite subit 1 blessure.",
		"name": "Saignement",
		"subtypes": "Malédiction de Créature",
		"type": 2
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "2 Prairies",
		"def": 1,
		"description": "Quand vous découvrez 1 Lieu, infligez 1 blessure au Démiurge adverse.",
		"name": "Conquérant",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "2 Prairies",
		"def": 1,
		"description": "Quand vous découvrez 1 Lieu, infligez 1 blessure au Démiurge adverse.",
		"name": "Conquérant",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "2 Prairies",
		"def": 1,
		"description": "Quand vous découvrez 1 Lieu, infligez 1 blessure au Démiurge adverse.",
		"name": "Conquérant",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "2 Prairies",
		"def": 1,
		"description": "Quand vous découvrez 1 Lieu, infligez 1 blessure au Démiurge adverse.",
		"name": "Conquérant",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Prairie",
		"def": 0,
		"description": "Les Créatures sur le Lieu maudit ont -2 de puissance.",
		"name": "Affaiblissement",
		"subtypes": "Malédiction de Lieu",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Prairie",
		"def": 0,
		"description": "Les Créatures sur le Lieu maudit ont -2 de puissance.",
		"name": "Affaiblissement",
		"subtypes": "Malédiction de Lieu",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Prairie",
		"def": 0,
		"description": "Les Créatures sur le Lieu maudit ont -2 de puissance.",
		"name": "Affaiblissement",
		"subtypes": "Malédiction de Lieu",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Prairie",
		"def": 0,
		"description": "Les Créatures sur le Lieu maudit ont -2 de puissance.",
		"name": "Affaiblissement",
		"subtypes": "Malédiction de Lieu",
		"type": 2
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "Invocation : infligez 1 blessure au Démiurge adverse pour chacune de vos Malédictions.",
		"name": "Jeteuse de sortilèges",
		"subtypes": "Orc - Sorcier",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "Invocation : infligez 1 blessure au Démiurge adverse pour chacune de vos Malédictions.",
		"name": "Jeteuse de sortilèges",
		"subtypes": "Orc - Sorcier",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "Invocation : infligez 1 blessure au Démiurge adverse pour chacune de vos Malédictions.",
		"name": "Jeteuse de sortilèges",
		"subtypes": "Orc - Sorcier",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "Invocation : infligez 1 blessure au Démiurge adverse pour chacune de vos Malédictions.",
		"name": "Jeteuse de sortilèges",
		"subtypes": "Orc - Sorcier",
		"type": 1
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Prairie",
		"def": 0,
		"description": "Infligez 2 blessures.",
		"name": "Frappe élémentaire",
		"subtypes": "Intervention",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Prairie",
		"def": 0,
		"description": "Infligez 2 blessures.",
		"name": "Frappe élémentaire",
		"subtypes": "Intervention",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Prairie",
		"def": 0,
		"description": "Infligez 2 blessures.",
		"name": "Frappe élémentaire",
		"subtypes": "Intervention",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Prairie",
		"def": 0,
		"description": "Infligez 2 blessures.",
		"name": "Frappe élémentaire",
		"subtypes": "Intervention",
		"type": 2
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "Attaque : un autre de vos Orcs a +1 de puissance.",
		"name": "Fidèle du sang",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "Attaque : un autre de vos Orcs a +1 de puissance.",
		"name": "Fidèle du sang",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "Attaque : un autre de vos Orcs a +1 de puissance.",
		"name": "Fidèle du sang",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "1 Prairie",
		"def": 1,
		"description": "Attaque : un autre de vos Orcs a +1 de puissance.",
		"name": "Fidèle du sang",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 1,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Créature",
		"def": 1,
		"description": "Vos Créatures adjacentes à elle ont +1 de puissance.",
		"name": "Hache de guerre",
		"subtypes": "Arme",
		"type": 4
		}, {
		"atk": 1,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Créature",
		"def": 1,
		"description": "Vos Créatures adjacentes à elle ont +1 de puissance.",
		"name": "Hache de guerre",
		"subtypes": "Arme",
		"type": 4
		}, {
		"atk": 1,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Créature",
		"def": 1,
		"description": "Vos Créatures adjacentes à elle ont +1 de puissance.",
		"name": "Hache de guerre",
		"subtypes": "Arme",
		"type": 4
		}, {
		"atk": 1,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Créature",
		"def": 1,
		"description": "Vos Créatures adjacentes à elle ont +1 de puissance.",
		"name": "Hache de guerre",
		"subtypes": "Arme",
		"type": 4
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "3 Prairies",
		"def": 0,
		"description": "Chaque fois que des blessures sont infligées à l'Entité maudite, infligez-lui 1 blessure supplémentaire.",
		"name": "Soif écarlate",
		"subtypes": "Malédiction d'Entité",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "3 Prairies",
		"def": 0,
		"description": "Chaque fois que des blessures sont infligées à l'Entité maudite, infligez-lui 1 blessure supplémentaire.",
		"name": "Soif écarlate",
		"subtypes": "Malédiction d'Entité",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "3 Prairies",
		"def": 0,
		"description": "Chaque fois que des blessures sont infligées à l'Entité maudite, infligez-lui 1 blessure supplémentaire.",
		"name": "Soif écarlate",
		"subtypes": "Malédiction d'Entité",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "3 Prairies",
		"def": 0,
		"description": "Chaque fois que des blessures sont infligées à l'Entité maudite, infligez-lui 1 blessure supplémentaire.",
		"name": "Soif écarlate",
		"subtypes": "Malédiction d'Entité",
		"type": 2
		}, {
		"atk": 3,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "3 Prairies",
		"def": 1,
		"description": "Chaque fois qu'une de vos cartes inflige des blessures, elle en inflige 2 supplémentaires.",
		"name": "Exalteur écarlate",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 3,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "3 Prairies",
		"def": 1,
		"description": "Chaque fois qu'une de vos cartes inflige des blessures, elle en inflige 2 supplémentaires.",
		"name": "Exalteur écarlate",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 3,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "3 Prairies",
		"def": 1,
		"description": "Chaque fois qu'une de vos cartes inflige des blessures, elle en inflige 2 supplémentaires.",
		"name": "Exalteur écarlate",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 3,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints":
		 "3 Prairies",
		"def": 1,
		"description": "Chaque fois qu'une de vos cartes inflige des blessures, elle en inflige 2 supplémentaires.",
		"name": "Exalteur écarlate",
		"subtypes": "Orc",
		"type": 1
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "Découverte : infligez 1 blessure au Démiurge adverse.",
		"name": "Herbes ensanglantées",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "Vos Créatures dessus ont +1 de puissance.",
		"name": "Prairies ancestrales",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Prairie",
		"subtypes": "Prairie",
		"type": 0
		} ]
	decks["Empire d'Éleuther (C) B"] = [ {
		"atk": 2,
		"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
		"constraints": "1 Champ",
		"def": 2,
		"description": "",
		"name": "Soldat",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
		"constraints": "1 Champ",
		"def": 2,
		"description": "",
		"name": "Soldat",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
		"constraints": "1 Champ",
		"def": 2,
		"description": "",
		"name": "Soldat",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
		"constraints": "1 Champ",
		"def": 2,
		"description": "",
		"name": "Soldat",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 1,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Champ",
		"def": 3,
		"description": "Défensif.",
		"name": "Barricades",
		"subtypes": "Édifice",
		"type": 4
		}, {
		"atk": 1,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Champ",
		"def": 3,
		"description": "Défensif.",
		"name": "Barricades",
		"subtypes": "Édifice",
		"type": 4
		}, {
		"atk": 1,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Champ",
		"def": 3,
		"description": "Défensif.",
		"name": "Barricades",
		"subtypes": "Édifice",
		"type": 4
		}, {
		"atk": 1,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Champ",
		"def": 3,
		"description": "Défensif.",
		"name": "Barricades",
		"subtypes": "Édifice",
		"type": 4
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "4 Champs",
		"def": 0,
		"description": "Vos Créatures adjacentes à au moins une de vos Créatures ont +1/+1.",
		"name": "Ralliement",
		"subtypes": "Intervention",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "4 Champs",
		"def": 0,
		"description": "Vos Créatures adjacentes à au moins une de vos Créatures ont +1/+1.",
		"name": "Ralliement",
		"subtypes": "Intervention",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "4 Champs",
		"def": 0,
		"description": "Vos Créatures adjacentes à au moins une de vos Créatures ont +1/+1.",
		"name": "Ralliement",
		"subtypes": "Intervention",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "4 Champs",
		"def": 0,
		"description": "Vos Créatures adjacentes à au moins une de vos Créatures ont +1/+1.",
		"name": "Ralliement",
		"subtypes": "Intervention",
		"type": 2
		}, {
		"atk": 2,
		"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
		"constraints": "2 Champs",
		"def": 2,
		"description": "Invocation : infligez 2 blessures à une Créature adverse.",
		"name": "Lanceuse de javelot",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
		"constraints": "2 Champs",
		"def": 2,
		"description": "Invocation : infligez 2 blessures à une Créature adverse.",
		"name": "Lanceuse de javelot",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
		"constraints": "2 Champs",
		"def": 2,
		"description": "Invocation : infligez 2 blessures à une Créature adverse.",
		"name": "Lanceuse de javelot",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.941176, 0.901961, 0.54902, 1 ),
		"constraints": "2 Champs",
		"def": 2,
		"description": "Invocation : infligez 2 blessures à une Créature adverse.",
		"name": "Lanceuse de javelot",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Champ - 1 Créature",
		"def": 2,
		"description": "Offensif.",
		"name": "Bélier à tête",
		"subtypes": "Engin",
		"type": 4
		}, {
		"atk": 4,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Champ - 1 Créature",
		"def": 2,
		"description": "Offensif.",
		"name": "Bélier à tête",
		"subtypes": "Engin",
		"type": 4
		}, {
		"atk": 4,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Champ - 1 Créature",
		"def": 2,
		"description": "Offensif.",
		"name": "Bélier à tête",
		"subtypes": "Engin",
		"type": 4
		}, {
		"atk": 4,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "1 Champ - 1 Créature",
		"def": 2,
		"description": "Offensif.",
		"name": "Bélier à tête",
		"subtypes": "Engin",
		"type": 4
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Champ - 1 Créature",
		"def": 0,
		"description": "La Construction bénie a Migration 1.",
		"name": "Rondins de transport",
		"subtypes": "Bénédiction de Construction",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Champ - 1 Créature",
		"def": 0,
		"description": "La Construction bénie a Migration 1.",
		"name": "Rondins de transport",
		"subtypes": "Bénédiction de Construction",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Champ - 1 Créature",
		"def": 0,
		"description": "La Construction bénie a Migration 1.",
		"name": "Rondins de transport",
		"subtypes": "Bénédiction de Construction",
		"type": 2
		}, {
		"atk": 0,
		"color": Color( 1, 0.631373, 0.478431, 1 ),
		"constraints": "1 Champ - 1 Créature",
		"def": 0,
		"description": "La Construction bénie a Migration 1.",
		"name": "Rondins de transport",
		"subtypes": "Bénédiction de Construction",
		"type": 2
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "3 Champs",
		"def": 2,
		"description": "Chaque fois que vous invoquez une Créature, piochez la première Créature de votre deck.",
		"name": "Recruteuse de troupes",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "3 Champs",
		"def": 2,
		"description": "Chaque fois que vous invoquez une Créature, piochez la première Créature de votre deck.",
		"name": "Recruteuse de troupes",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "3 Champs",
		"def": 2,
		"description": "Chaque fois que vous invoquez une Créature, piochez la première Créature de votre deck.",
		"name": "Recruteuse de troupes",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "3 Champs",
		"def": 2,
		"description": "Chaque fois que vous invoquez une Créature, piochez la première Créature de votre deck.",
		"name": "Recruteuse de troupes",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 2,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "5 Champs",
		"def": 8,
		"description": "Invocation : vos Créatures ont +2 de résistance.",
		"name": "Camp fortifié",
		"subtypes": "Édifice",
		"type": 4
		}, {
		"atk": 2,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "5 Champs",
		"def": 8,
		"description": "Invocation : vos Créatures ont +2 de résistance.",
		"name": "Camp fortifié",
		"subtypes": "Édifice",
		"type": 4
		}, {
		"atk": 2,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "5 Champs",
		"def": 8,
		"description": "Invocation : vos Créatures ont +2 de résistance.",
		"name": "Camp fortifié",
		"subtypes": "Édifice",
		"type": 4
		}, {
		"atk": 2,
		"color": Color( 0.690196, 0.768627, 0.870588, 1 ),
		"constraints": "5 Champs",
		"def": 8,
		"description": "Invocation : vos Créatures ont +2 de résistance.",
		"name": "Camp fortifié",
		"subtypes": "Édifice",
		"type": 4
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "4 Champs",
		"def": 3,
		"description":
		 "Chaque fois qu'il combat une Créature, il a +1/+1.",
		"name": "Épéiste expérimenté",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "4 Champs",
		"def": 3,
		"description": "Chaque fois qu'il combat une Créature, il a +1/+1.",
		"name": "Épéiste expérimenté",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "4 Champs",
		"def": 3,
		"description": "Chaque fois qu'il combat une Créature, il a +1/+1.",
		"name": "Épéiste expérimenté",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "4 Champs",
		"def": 3,
		"description": "Chaque fois qu'il combat une Créature, il a +1/+1.",
		"name": "Épéiste expérimenté",
		"subtypes": "Humain",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "5 Champs",
		"def": 4,
		"description": "Migration 2. Les Créatures adverses non-Humain ont -1/-1.",
		"name": "Chevalier de l'Ordre des Éleuthes",
		"subtypes": "Humain - Cavalier",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "5 Champs",
		"def": 4,
		"description": "Migration 2. Les Créatures adverses non-Humain ont -1/-1.",
		"name": "Chevalier de l'Ordre des Éleuthes",
		"subtypes": "Humain - Cavalier",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "5 Champs",
		"def": 4,
		"description": "Migration 2. Les Créatures adverses non-Humain ont -1/-1.",
		"name": "Chevalier de l'Ordre des Éleuthes",
		"subtypes": "Humain - Cavalier",
		"type": 1
		}, {
		"atk": 4,
		"color": Color( 0.94, 0.9, 0.55, 1 ),
		"constraints": "5 Champs",
		"def": 4,
		"description": "Migration 2. Les Créatures adverses non-Humain ont -1/-1.",
		"name": "Chevalier de l'Ordre des Éleuthes",
		"subtypes": "Humain - Cavalier",
		"type": 1
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "Découverte : la prochaine Créature que vous invoquez ce tour-ci nécessite 1 Contrainte de moins.",
		"name": "Terres cultivables",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "Vos Entités dessus ont +1/+1 en combat.",
		"name": "Colline de tournesols",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		}, {
		"atk": 0,
		"color": Color( 0.6, 0.980392, 0.6, 1 ),
		"constraints": "",
		"def": 0,
		"description": "",
		"name": "Champ",
		"subtypes": "Champ",
		"type": 0
		} ]

