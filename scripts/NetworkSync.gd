extends Panel
class_name NetworkSync

remotesync func start_game():
	var scene = load("res://scenes/Game.tscn").instance()
	scene.deck1 = $deck_selector/select.get_selected_metadata()
	var tree = get_tree()
	var root = tree.get_root()
	Util.delete_children(root)
	root.add_child(scene)
