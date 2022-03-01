extends HBoxContainer

signal connect_to_host(code)

func on_connect_pressed():
	emit_signal("connect_to_host")

func setup(name: String, disable_btn: bool):
	$name.text = name
	$connect_btn.connect("pressed", self, "on_connect_pressed")
	$connect_btn.disabled = disable_btn
