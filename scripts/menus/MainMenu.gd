extends Panel

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _ready():
	$menu/play_btn.connect("pressed", self, "play_clicked")
	$menu/collection_btn.connect("pressed", self, "collection_clicked")
	$menu/hbox_edition/deck_btn.connect("pressed", self, "deck_clicked")
	$menu/hbox_edition/cards_btn.connect("pressed", self, "cards_clicked")
	$settings_btn.connect("pressed", self, "settings_pressed")

func play_clicked():
	get_tree().change_scene("res://scenes/menus/PlayMenu.tscn")

func collection_clicked():
	get_tree().change_scene("res://scenes/Collection.tscn")

func deck_clicked():
	get_tree().change_scene("res://scenes/DeckEditor.tscn")

func cards_clicked():
	get_tree().change_scene("res://scenes/CardEditor.tscn")

func settings_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")
