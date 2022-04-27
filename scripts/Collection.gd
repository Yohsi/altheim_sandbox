extends Panel

func _ready() -> void:
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$header/open_file.connect("pressed", DeckList, "open_file")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func back_btn_pressed():
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")

