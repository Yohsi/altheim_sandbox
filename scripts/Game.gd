extends Panel

var CardScene = preload("res://scenes/CardView.tscn")

var preview_node : CardView
var preview_id : String
var local_game = false
var our_id = 0
var opponent_id = 1

static func true_size(node: Control) -> Vector2:
	return node.rect_size * node.rect_scale

func show_preview(state, card, id):
	if state:
		if preview_id != id:
			preview_id = id
			var base := preview_node.rect_size
			var scaled := true_size(preview_node)
			var offset := (scaled - base) / 2
			preview_node.set_position(Vector2(rect_size.x - scaled.x + offset.x, offset.y))
			preview_node.card = card
			preview_node.visible = true
	else:
		if preview_id == id:
			preview_node.visible = false
			preview_id = ""

func on_player_disconnected(id):
	if id == opponent_id:
		quit_game()

func quit_game():
	get_tree().change_scene("res://scenes/Main.tscn")
	queue_free()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		quit_game()

func _exit_tree() -> void:
	get_tree().network_peer = null

# decks is a dictionary {id1 -> deck1, id2, deck2}. To start a local game, set id1 to 0
func setup(decks: Dictionary):
	preview_node = CardScene.instance()
	add_child(preview_node)
	preview_node.name = "preview"
	preview_node.local_game = local_game
	preview_node.setup_preview(null)
	preview_node.rect_scale = 0.8*Vector2.ONE
	preview_node.visible = false
	preview_node.mouse_filter = MOUSE_FILTER_IGNORE

	local_game = get_tree().network_peer == null

	if local_game:
		$copy_deck.visible = false
	else:
		our_id = get_tree().get_network_unique_id()
		var peer := get_tree().network_peer
		peer.connect("peer_disconnected", self, "on_player_disconnected")
		peer.connect("server_disconnected", self, "quit_game")

	for id in decks:
		if id != our_id:
			opponent_id = id
	for id in decks:
		setup_deck(id, decks[id])

	raise_cards()

	var health_own = $health_own
	health_own.local_game = local_game
	health_own.opponent_id = opponent_id
	health_own.name = "health_%d" % our_id
	var health_other = $health_other
	health_other.local_game = local_game
	health_other.opponent_id = opponent_id
	health_other.name = "health_%d" % opponent_id

func _ready():
	$back.connect("pressed", self, "quit_game")

func copy_deck(deck):
	var deck_list = DeckList.new()
	var name: String = "Deck copié"
	var n = 1
	while deck_list.decks.has("%s%d" % [name, n]):
		n += 1
	deck_list.decks["%s %d" % [name, n]] = deck
	deck_list.write()

func setup_deck(owner_id, deck):
	var own = owner_id == our_id
	var place_index := 1 if own else 16
	var card_index := 1 if own else 41
	var new_index := 1

	if not own:
		$copy_deck.connect("pressed", self, "copy_deck", [deck])

	for card in deck:
		var type : String
		var index : int
		if card.type == CardType.Place:
			type = "place"
			index = place_index
			place_index +=1
		else:
			type = "card"
			index = card_index
			card_index +=1

		var card_node := get_node_or_null("%s_%d" % [type, index])
		if card_node == null:
			card_node = CardScene.instance()
			add_child(card_node)
			card_node.rect_scale = 0.35 * Vector2.ONE
			var x := 1600
			var y := 400
			if card.type == CardType.Place:
				x = 0
			if not own:
				y = rect_size.y - y - card_node.rect_size.y
			card_node.set_position(Vector2(x, y))

		var vis = CardView.VisibleBy.NOBODY
		if own and card.type == CardType.Place and (index%15 == 0 or index%15 == 14):
			vis = CardView.VisibleBy.ME
		card_node.name = "%s_%d_%d" % [type, owner_id, new_index]
		card_node.local_game = local_game
		card_node.setup(card, vis, opponent_id)
		card_node.visible = true
		card_node.connect("show_preview", self, "show_preview")
		card_node.connect("raise_preview", preview_node, "raise")
		card_node.raise()
		new_index += 1

	var stop = 16 if own else 31
	for i in range(place_index, stop):
		get_node("place_%d" % i).queue_free()

func raise_cards():
	for card in get_children():
		if card.name.begins_with("card"):
			card.raise()
	get_node("preview").raise()
