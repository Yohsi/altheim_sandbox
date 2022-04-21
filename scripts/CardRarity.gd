class_name CardRarity

enum {BANAL, REMARKABLE, EXCEPTIONAL, UNIQUE}

static func from_str(string: String):
	match string.to_lower():
		"banale":
			return BANAL
		"remarquable":
			return REMARKABLE
		"exceptionnelle":
			return EXCEPTIONAL
		"unique":
			return UNIQUE
		_:
			return null

static func to_str(rarity) -> String:
	match rarity:
		BANAL:
			return "Banale"
		REMARKABLE:
			return "Remarquable"
		EXCEPTIONAL:
			return "Exceptionnelle"
		UNIQUE:
			return "Unique"
		_:
			return ""

static func color_of(rarity) -> Color:
	match rarity:
		BANAL:
			return Color.black
		REMARKABLE:
			return Color.blue
		EXCEPTIONAL:
			return Color.tomato
		UNIQUE:
			return Color.yellow
		_:
			return Color.black
