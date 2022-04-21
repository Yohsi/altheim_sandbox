extends AspectRatioContainer

export(float) var card_scale = 1.0 setget set_card_scale

signal clicked()

func _ready() -> void:
	$texture_rect.texture.viewport_path = $viewport.get_path()
	$btn.connect("pressed", self, "emit_signal", ["clicked"])

func set_card_scale(new_scale: float):
	var size = Vector2(389,543) * new_scale
	rect_min_size = size
	rect_size = size
