extends Panel

func back_btn_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func _ready() -> void:
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$menu/host_btn.connect("pressed", self, "on_host_clicked")
	$menu/join_btn.connect("pressed", self, "on_join_clicked")

func on_host_clicked():
	get_tree().change_scene("res://scenes/MainHost.tscn")

func on_join_clicked():
	get_tree().change_scene("res://scenes/MainClient.tscn")

