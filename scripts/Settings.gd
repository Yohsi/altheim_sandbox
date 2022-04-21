extends Panel

var config := ConfigFile.new()

const PATH := "user://preference.cfg"
const SECTION := "preferences"

onready var full_screen_btn = $list/full_screen

func back_btn_pressed():
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")

func _ready() -> void:
	config.load(PATH)
	var full_screen = config.get_value(SECTION, "full_screen", true)
	full_screen_btn.pressed = full_screen
	full_screen_btn.connect("pressed", self, "_full_screen_toggled")

func _full_screen_toggled():
	OS.window_fullscreen = full_screen_btn.pressed
	config.set_value(SECTION, "full_screen", full_screen_btn.pressed)
	config.save(PATH)
