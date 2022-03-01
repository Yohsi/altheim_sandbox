extends Node

var ArgParser = load("res://scripts/ArgParser.gd")

var ip: String
var port: int
var is_server: bool

func _ready():
	var default_serv = OS.has_feature("Server")

	var opts = ArgParser.Options.new()
	opts.set_banner('Altheim client or server.\n' +
					'Any option that requires a value will take the form of "--<option>=<value>".')
	opts.add('--ip', '92.157.70.8', 'The IP address of the server. Default 92.157.70.8')
	opts.add('--port', 34210, 'The port the server listens on. Default 34210')
	opts.add('--server', default_serv, 'Run the server. Default %s' % default_serv)
	opts.add('--altheim-help', false, 'Print this help')
	opts.parse()

	ip = opts.get_value('--ip')
	port = opts.get_value('--port')
	is_server = opts.get_value('--server')
	var print_help = opts.get_value('--altheim-help')

	if print_help:
		opts.print_help()
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
