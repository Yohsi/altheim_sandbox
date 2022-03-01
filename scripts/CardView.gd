extends Control
class_name CardView

signal show_preview(state, card, id)
signal raise_preview()

enum VisibleBy {BOTH, NOBODY, ME}

var card setget set_card
var preview := false
var clicking := false
var click_position: Vector2
var initial_position: Vector2
var initial_touch_position: Vector2
var touch_time
var dragged = true
var visible_by = VisibleBy.NOBODY
var rotated_landscape = false
var local_game = false setget set_local_game

var opponent_id: int # the id of the remote player (not related to the card ownership)

func set_local_game(b):
	local_game = b
	if local_game:
		$card/front/visibity_indicator.visible = false

func set_card(new_card) -> void:
	card = new_card
	update_card_info()

func rpc_or_call(f, arg = null):
	if arg == null:
		call(f)
		if not local_game and not preview:
			rpc_id(opponent_id, f)
	else:
		call(f, arg)
		if not local_game and not preview:
			rpc_id(opponent_id, f, arg)

func rpc_unreliable_or_call(f, arg = null):
	if arg == null:
		call(f)
		if not local_game and not preview:
			rpc_unreliable_id(opponent_id, f)
	else:
		call(f, arg)
		if not local_game and not preview:
			rpc_unreliable_id(opponent_id, f, arg)

func update_card_info():
	if (card == null):
		return
	$card/front/name.text = card.name
	$card/front/description_container.visible = card.description != ""
	$card/front/description_container/description.text = card.description
	$card/front/atk.text = str(card.atk)
	$card/front/def.text = str(card.def)
	$card/front/atk.visible = card.type == CardType.Creature or card.type == CardType.Construction
	$card/front/def.visible = card.type == CardType.Creature or card.type == CardType.Construction
	$card/front/constraints.text = card.constraints
	$card/front/subtypes.text = card.subtypes
	$card/front/type.text = CardType.to_str(card.type)

	match card.type:
		CardType.Creature:
			$card/front/overlay.texture = load("res://assets/creature_front.png")
		CardType.Construction:
			$card/front/overlay.texture = load("res://assets/creature_front.png")
		CardType.Place:
			$card/front/overlay.texture = load("res://assets/place_front.png")
		CardType.Divinity:
			$card/front/overlay.texture = load("res://assets/divinity_front.png")
		CardType.Miracle:
			$card/front/overlay.texture = load("res://assets/miracle_front.png")

	$card/front/background.color = card.color


func setup_preview(p_card):
	self.visible_by = VisibleBy.BOTH
	self.preview = true
	$card/front/visibity_indicator.visible = false
	flip_card(true)
	self.card = p_card

func setup(p_card, visibility, p_opponent_id) -> void:
	self.opponent_id = p_opponent_id
	self.visible_by = visibility
	self.preview = false
	if visibility != VisibleBy.NOBODY:
		update_visibility()
	self.card = p_card

func bounding_box() -> Rect2:
	var size := rect_size*rect_scale
	var pos := rect_global_position
	if rotated_landscape:
		var tmp = size.y
		size.y = size.x
		size.x = tmp
		pos.y = pos.y - size.y
	return Rect2(pos, size)

func in_bounds(pos: Vector2) -> bool:
	return bounding_box().has_point(pos)

func to_the_left(v: Vector2) -> bool:
	var size := rect_size*rect_scale
	var pos := rect_global_position
	size.x /= 2
	if rotated_landscape:
		var tmp = size.y
		size.y = size.x
		size.x = tmp
		pos.y = pos.y - size.y
	return Rect2(pos, size).has_point(v)

remote func raise_card():
	raise()
	emit_signal("raise_preview")

func cycle_visibility():
	if local_game:
		visible_by = (visible_by + 1) % 2
	else:
		visible_by = (visible_by + 1) % 3
	update_visibility()

func _on_right_click(event: InputEventMouseButton) -> bool:
	if not event.pressed and in_bounds(event.position):
		cycle_visibility()
		return not event.control
	return false

func _on_screen_drag(event: InputEventScreenDrag) -> bool:
	if not dragged and event.position.distance_squared_to(initial_touch_position) > 200:
		dragged = true
	return false

func _on_screen_touch(event: InputEventScreenTouch) -> bool:
	var pos = event.position
	var in_bounds = in_bounds(pos)
	var show_preview = visible_by != VisibleBy.NOBODY and in_bounds and event.pressed
	emit_signal("show_preview", show_preview, card, name)
	if event.pressed and in_bounds:
		dragged = false
		touch_time = OS.get_ticks_msec()
		initial_touch_position = pos
		return true
	if not event.pressed and in_bounds and not dragged and OS.get_ticks_msec() - touch_time < 200:
		cycle_visibility()
		return true
	return false

func _on_left_click(event: InputEventMouseButton) -> bool:
	if event.pressed and event.shift and in_bounds(event.position):
		rpc_or_call("raise_card")
		return true
	if event.pressed and in_bounds(event.position):
		clicking = true
		click_position = event.position
		initial_position = rect_position
		return not event.control
	if clicking and not event.pressed:
		clicking = false
	return false

func _on_middle_click(event: InputEventMouseButton) -> bool:
	if event.pressed and in_bounds(event.position):
		rpc_or_call("rotate_card", not rotated_landscape)
		return not event.control
	return false

func _on_mouse_wheel(event: InputEventMouseButton) -> bool:
	if event.pressed and visible_by != VisibleBy.NOBODY and in_bounds(event.position):
		var f := "add_atk" if to_the_left(event.position) else "add_def"
		var amount := 1 if event.button_index == BUTTON_WHEEL_UP else -1
		rpc_or_call(f, amount)
		return true
	return false

func _on_mouse_move(event : InputEventMouseMotion) -> bool:
	if clicking:
		rpc_unreliable_or_call("set_card_position", initial_position + event.position - click_position)
		return false
	if not (event.button_mask & BUTTON_LEFT):
		var mouse_in_bounds = in_bounds(event.position)
		var visible_side = visible_by != VisibleBy.NOBODY
		var show_preview = mouse_in_bounds and visible_side
		emit_signal("show_preview", show_preview, card, name)
		return mouse_in_bounds
	return false

func _input(event: InputEvent) -> void:
	if preview:
		return
	var handle_input := false

	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			handle_input = _on_left_click(event)
		elif event.button_index == BUTTON_RIGHT:
			handle_input = _on_right_click(event)
		elif event.button_index == BUTTON_MIDDLE:
			handle_input = _on_middle_click(event)
		elif event.button_index == BUTTON_WHEEL_DOWN or event.button_index == BUTTON_WHEEL_UP:
			handle_input = _on_mouse_wheel(event)
	elif event is InputEventMouseMotion:
		handle_input = _on_mouse_move(event)
	elif event is InputEventScreenTouch:
		handle_input = _on_screen_touch(event)
	elif event is InputEventScreenDrag:
		handle_input = _on_screen_drag(event)

	if handle_input:
		get_tree().set_input_as_handled()

func update_visibility():
	match visible_by:
		VisibleBy.BOTH:
			rpc_or_call("flip_card", true)
		VisibleBy.ME:
			rpc_or_call("flip_card", false)
			flip_card(true)
			visible_by = VisibleBy.ME
			$card/front/visibity_indicator.set("custom_colors/font_color", Color("f45940"))
			$card/front/visibity_indicator.text = "Caché"
		VisibleBy.NOBODY:
			rpc_or_call("flip_card", false)

remote func flip_card(visible: bool):
	visible_by = VisibleBy.BOTH if visible else VisibleBy.NOBODY
	$card/back.visible = not visible
	$card/front.visible = visible
	if visible:
		$card/front/visibity_indicator.set("custom_colors/font_color", Color("58f74f"))
		$card/front/visibity_indicator.text = "Visible"

remote func set_card_position(pos:Vector2):
	if not local_game:
		if get_tree().get_rpc_sender_id() == opponent_id:
			pos.y = get_parent().rect_size.y - pos.y - rect_size.y
	set_position(pos)

remote func rotate_card(landscape: bool):
	rotated_landscape = landscape
	set_rotation(-PI/2 if landscape else 0.0)

remote func add_def(amount: int):
	var new_def = int($card/front/def.text) + amount
	$card/front/def.text = str(new_def)
	var color
	if new_def > card.def:
		color = Color.forestgreen
	elif new_def < card.def:
		color = Color.crimson
	else:
		color = Color.black
	$card/front/def.set("custom_colors/font_color", color)

remote func add_atk(amount: int):
	var new_atk = int($card/front/atk.text) + amount
	$card/front/atk.text = str(new_atk)
	var color
	if new_atk > card.atk:
		color = Color.forestgreen
	elif new_atk < card.atk:
		color = Color.crimson
	else:
		color = Color.black
	$card/front/atk.set("custom_colors/font_color", color)

func _ready() -> void:
	set_process_input(not preview)
	rotated_landscape = get_rotation() != 0
	update_card_info()
	mouse_filter = MOUSE_FILTER_PASS

