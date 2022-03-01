extends Panel

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _ready():
	$menu/online_btn.connect("pressed", self, "online_clicked")
	$menu/lan_btn.connect("pressed", self, "lan_clicked")
	$menu/local_btn.connect("pressed", self, "local_clicked")
	$menu/deck_btn.connect("pressed", self, "deck_clicked")

func online_clicked():
	get_tree().change_scene("res://scenes/OnlineMenu.tscn")

func lan_clicked():
	get_tree().change_scene("res://scenes/LanMenu.tscn")

func local_clicked():
	get_tree().change_scene("res://scenes/StartLocalGame.tscn")

func deck_clicked():
	get_tree().change_scene("res://scenes/DeckEditor.tscn")
