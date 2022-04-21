extends Panel

func back_btn_pressed():
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func _ready() -> void:
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$menu/online_btn.connect("pressed", self, "on_online_clicked")
	$menu/hbox/host_btn.connect("pressed", self, "on_host_clicked")
	$menu/hbox/join_btn.connect("pressed", self, "on_join_clicked")
	$menu/local_btn.connect("pressed", self, "on_local_clicked")

func on_online_clicked():
	get_tree().change_scene("res://scenes/menus/OnlineMenu.tscn")

func on_host_clicked():
	get_tree().change_scene("res://scenes/menus/MainHost.tscn")

func on_join_clicked():
	get_tree().change_scene("res://scenes/menus/MainClient.tscn")

func on_local_clicked():
	get_tree().change_scene("res://scenes/menus/LocalMenu.tscn")

