extends Node

var ArgParser = load("res://scripts/ArgParser.gd")

func _ready() -> void:
	randomize()

	if Args.is_server:
		get_tree().change_scene("res://scenes/Server.tscn")
	else:
		get_tree().change_scene("res://scenes/MainMenu.tscn")

