class_name Util

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

static func set_font_color(node, color):
	node.set("custom_colors/font_color", color)
	node.set("custom_colors/font_color_focus", color)
	node.set("custom_colors/font_color_hover", color)
	node.set("custom_colors/font_color_pressed", color)
