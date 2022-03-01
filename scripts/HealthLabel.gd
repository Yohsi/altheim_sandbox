extends Label

var local_game = false
var opponent_id: int

func in_bounds(pos: Vector2) -> bool:
	return Rect2(rect_global_position, rect_size).has_point(pos)

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and in_bounds(event.position):
		if event.button_index == BUTTON_WHEEL_DOWN:
			add_health(-1)
			if not local_game:
				rpc_id(opponent_id, "add_health", -1)

		elif event.button_index == BUTTON_WHEEL_UP:
			add_health(1)
			if not local_game:
				rpc_id(opponent_id, "add_health", 1)
		get_tree().set_input_as_handled()

remote func add_health(amount: int):
	var new_health = int(text) + amount
	text = str(new_health)

func _ready() -> void:
	pass
