extends HBoxContainer

signal connect_to_host(code)
var host_code

func on_connect_pressed():
	emit_signal("connect_to_host", host_code)

func setup(ip : String, code : String):
	host_code = code
	$IP.text = ip
	$Code.text = code
	$Connect_btn.connect("pressed", self, "on_connect_pressed")
