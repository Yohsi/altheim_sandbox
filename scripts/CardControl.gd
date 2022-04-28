extends AspectRatioContainer

export(float) var card_scale = 1.0 setget set_card_scale

signal clicked()
signal edit_clicked()

func _ready() -> void:
	$texture_rect.texture.viewport_path = $viewport.get_path()
	$btn.connect("pressed", self, "emit_signal", ["clicked"])
	$edit_btn.connect("pressed", self, "emit_signal", ["edit_clicked"])
	set_process_input(true)

func set_card_scale(new_scale: float):
	var size = Vector2(389,543) * new_scale
	rect_min_size = size
	rect_size = size

func in_bounds(pos) -> bool:
	return Rect2(rect_global_position, rect_size*rect_scale).has_point(pos)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if in_bounds(event.position):
			$edit_btn.visible = true
		else:
			$edit_btn.visible = false
