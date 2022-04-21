extends Panel

onready var collection = $vbox/collection_view
onready var slider = $vbox/options/slider
onready var sort_options = $vbox/options/sort_options

func _ready() -> void:
	collection.set_cards_scale(slider.value)
	$header/back_btn.connect("pressed", self, "back_btn_pressed")
	$header/open_file.connect("pressed", DeckList, "open_file")

	sort_options.add_item("Type", 0)
	sort_options.set_item_metadata(0, "type")
	sort_options.add_item("Nom", 1)
	sort_options.set_item_metadata(1, "name")
	sort_options.add_item("Rareté", 2)
	sort_options.set_item_metadata(2, "rarity")
	sort_options.add_item("Extension", 3)
	sort_options.set_item_metadata(3, "extension")
	sort_options.connect("item_selected", self, "on_sort_changed")


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_btn_pressed()

func on_sort_changed(_index):
	collection.sort(sort_options.get_selected_metadata())

func back_btn_pressed():
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")

