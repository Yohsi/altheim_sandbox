extends NetworkSync

var _game_network_sync

func _on_update_players_list():
	if len($EasyLANHost.players_connected) == 1:
		$EasyLANHost.stop_broadcast()
		var ids = $EasyLANHost.players_connected
		ids.append(get_tree().get_network_unique_id())
		.rpc("start_game")

func back_btn_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func _ready():
	$EasyLANHost.connect("update_players_list", self, "_on_update_players_list")
	$EasyLANHost.setup()
	$EasyLANHost.start_broadcast()
	$vbox/code_info/code.text = "%s" % $EasyLANHost.server_code
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


