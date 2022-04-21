extends Node

func _ready() -> void:
	randomize()

	if Args.is_server:
		get_tree().change_scene("res://scenes/Server.tscn")
	else:
		var config = ConfigFile.new()
		config.load("user://preference.cfg")
		OS.window_fullscreen = config.get_value("preferences", "full_screen", true)
		get_tree().change_scene("res://scenes/menus/MainMenu.tscn")

