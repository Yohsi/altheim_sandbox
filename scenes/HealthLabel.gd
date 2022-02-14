extends Label

var local_game = false

func in_bounds(pos: Vector2) -> bool:
	return Rect2(rect_global_position, rect_size).has_point(pos)

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and in_bounds(event.position):
		if event.button_index == BUTTON_WHEEL_DOWN:
			if local_game:
				add_health(-1)
			else:
				rpc("add_health", -1)
		elif event.button_index == BUTTON_WHEEL_UP:
			if local_game:
				add_health(1)
			else:
				rpc("add_health", 1)
		get_tree().set_input_as_handled()

remotesync func add_health(amount: int):
	var new_health = int(text) + amount
	text = str(new_health)

func _ready() -> void:
	pass
