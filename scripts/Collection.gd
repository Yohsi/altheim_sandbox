extends Panel

func _ready() -> void:
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$header/open_file.connect("pressed", DeckList, "open_file")
	$collection_view.connect("edit_card_clicked", self, "edit_card")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func back_btn_pressed():
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")

func edit_card(id):
	var scene = load("res://scenes/CardEditor.tscn").instance()
	scene.current_card_id = id
	var root = get_tree().get_root()
	Util.delete_children(root)
	root.add_child(scene)
