extends Panel
class_name NetworkSync

var opponent_deck: Array
var opponent_id: int = -1
var our_deck: Array
var our_id: int = -1

remote func set_opponent_info(id: int, deck: Array):
	opponent_id = id
	opponent_deck = deck
	if our_id != -1:
		start_game()

func set_our_info(id: int, deck: Array):
	our_id = id
	our_deck = deck
	if opponent_id != -1:
		start_game()

remotesync func start_game():
	var tree = get_tree()
	get_node("/root/lan_menu").queue_free()
	var scene = load("res://scenes/Game.tscn").instance()
	tree.get_root().add_child(scene)
	scene.setup({our_id: our_deck, opponent_id: opponent_deck})
