extends NetworkSync

onready var GameRoomNameEntry = preload("res://scenes/RoomEntry.tscn")

func _on_update_servers_list():
	for child in $rooms/list.get_children():
		child.queue_free()

	var keys = $EasyLANClient.server_codes.keys()
	for key in keys:
		var ip = $EasyLANClient.server_codes[key]
		var new_entry = GameRoomNameEntry.instance()
		new_entry.setup(ip, key)
		$rooms/list.add_child(new_entry)
		new_entry.connect("connect_to_host",self, "_on_connect_pressed")

func _on_connect_pressed(code):
	$EasyLANClient.connect_to_server_code(code)

func _on_connection_ok():
	var deck = $deck_selector/select.get_selected_metadata().duplicate()
	deck.shuffle()
	var id = get_tree().get_network_unique_id()	
	.rpc("set_opponent_info", id, deck)
	set_our_info(id, deck)

func back_btn_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func _ready():
	$EasyLANClient.setup()
	$EasyLANClient.connect("update_servers_list", self, "_on_update_servers_list")
	$EasyLANClient.connect("connection_ok", self, "_on_connection_ok")
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	var deck_list := DeckList.new()
	var i = 0
	for deck_name in deck_list.decks:
		var deck = deck_list.decks[deck_name]
		$deck_selector/select.add_item(deck_name, i)
		$deck_selector/select.set_item_metadata(i, deck)
		if deck_name == deck_list.default_deck:
			$deck_selector/select.select(i)
		i += 1
