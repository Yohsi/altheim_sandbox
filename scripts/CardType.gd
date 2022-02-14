class_name CardType

enum {Place, Creature, Miracle, Divinity, Construction}

static func from_str(string: String):
	match string.to_lower():
		"lieu":
			return Place
		"creature", "créature":
			return Creature
		"divinite", "divinité":
			return Divinity
		"miracle":
			return Miracle
		"construction":
			return Construction
		_:
			return null

static func to_str(type) -> String:
	match type:
		Place:
			return "Lieu"
		Creature:
			return "Créature"
		Divinity:
			return "Divinité"
		Miracle:
			return "Miracle"
		Construction:
			return "Construction"
		_:
			return ""
