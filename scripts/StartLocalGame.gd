extends Panel

func on_start_pressed():
	var scene = load("res://scenes/Game.tscn").instance()
	var deck1 = $deck_selector1/select.get_selected_metadata().duplicate()
	deck1.shuffle()
	var deck2 = $deck_selector2/select.get_selected_metadata().duplicate()
	deck2.shuffle()
	get_node("/root/local_menu").queue_free()
	get_tree().get_root().add_child(scene)
	scene.setup({0: deck1, 1: deck2})

func back_btn_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func _ready() -> void:
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$start_btn.connect("pressed", self, "on_start_pressed")
	var deck_list := DeckList.new()
	var i = 0
	for deck_name in deck_list.decks:
		var deck = deck_list.decks[deck_name]
		$deck_selector1/select.add_item(deck_name, i)
		$deck_selector1/select.set_item_metadata(i, deck)
		$deck_selector2/select.add_item(deck_name, i)
		$deck_selector2/select.set_item_metadata(i, deck)
		if deck_name == deck_list.default_deck:
			$deck_selector1/select.select(i)
			$deck_selector2/select.select(i)
		i += 1

