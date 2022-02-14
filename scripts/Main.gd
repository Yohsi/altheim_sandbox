extends Panel

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _ready():
	randomize()
	$menu/host_btn.connect("pressed", self, "_on_host_clicked")
	$menu/join_btn.connect("pressed", self, "_on_join_clicked")
	$menu/local_btn.connect("pressed", self, "_on_local_clicked")
	$menu/deck_btn.connect("pressed", self, "_on_deck_clicked")

func _on_host_clicked():
	get_tree().change_scene("res://scenes/MainHost.tscn")

func _on_join_clicked():
	get_tree().change_scene("res://scenes/MainClient.tscn")

func _on_local_clicked():
	get_tree().change_scene("res://scenes/StartLocalGame.tscn")

func _on_deck_clicked():
	get_tree().change_scene("res://scenes/DeckEditor.tscn")
