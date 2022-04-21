extends Panel

var RoomEntry = preload("res://scenes/OnlineRoomEntry.tscn")

var game_created = false
var deck_list := DeckList.new()

func back_btn_pressed():
	get_node("/root/server").queue_free()
	get_tree().network_peer = null
	get_tree().change_scene("res://scenes/menus/PlayMenu.tscn")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func _ready():
	var Server = load("res://scripts/Server.gd")
	var server = Server.new()
	server.name = "server"
	get_tree().get_root().call_deferred("add_child", server)
	server.connect("games_updated", self, "update_game_list")

	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$menu/create_game_btn.connect("pressed", self, "show_popup")
	$popup/margin/cont/ok.connect("pressed", self, "create_game")
	$popup.connect("about_to_show", self, "popup_showing")
	$popup.connect("popup_hide", self, "popup_hiding")
	$popup/margin/cont/name.connect("text_entered", self, "create_game")

	var i = 0
	for deck_name in deck_list.decks:
		$deck_selector/select.add_item(deck_name, i)
		$deck_selector/select.set_item_metadata(i, deck_name)
		if deck_name == deck_list.default_deck:
			$deck_selector/select.select(i)
		i += 1

func update_game_list(games: Dictionary):
	Util.delete_children($menu/rooms)
	for id in games:
		var name = games[id]
		var room = RoomEntry.instance()
		$menu/rooms.add_child(room)
		room.setup(name, game_created)
		room.connect("connect_to_host", self, "on_connect_pressed", [id])

func on_connect_pressed(id: int):
	var deck = deck_list.flatten_deck($deck_selector/select.get_selected_metadata())
	get_node("/root/server").rpc_id(1, "connect_to_game", id, deck)

func show_popup():
	$popup.popup()

func popup_showing():
	$popup_back.visible = true

func popup_hiding():
	$popup_back.visible = false

func create_game(name: String = $popup/margin/cont/name.text):
	$popup.hide()
	$menu/create_game_btn.disabled = true
	$deck_selector/select.disabled = true
	game_created = true
	var deck = deck_list.flatten_deck($deck_selector/select.get_selected_metadata())
	var server = get_node("/root/server")
	server.rpc_id(1, "create_game", name, deck)
