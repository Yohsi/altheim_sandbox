extends AspectRatioContainer

export(float) var card_scale = 1.0 setget set_card_scale

onready var texture_rect = $texture_rect

signal clicked()
signal edit_clicked()

func _ready() -> void:
	texture_rect.texture.viewport_path = $viewport.get_path()
	texture_rect.rect_pivot_offset = texture_rect.rect_size/2
	texture_rect.connect("resized", self, "texture_rect_size_changed")

	$btn.connect("pressed", self, "emit_signal", ["clicked"])
	$edit_btn.connect("pressed", self, "emit_signal", ["edit_clicked"])
	set_process_input(true)

func set_card_scale(new_scale: float):
	var size = Vector2(389,543) * new_scale
	rect_min_size = size
	rect_size = size

func play_focus_animation():
	$anim_player.play("focus")

func in_bounds(pos) -> bool:
	return Rect2(rect_global_position, rect_size*rect_scale).has_point(pos)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if in_bounds(event.position):
			$edit_btn.visible = true
		else:
			$edit_btn.visible = false

func texture_rect_size_changed():
	texture_rect.rect_pivot_offset = texture_rect.rect_size/2
