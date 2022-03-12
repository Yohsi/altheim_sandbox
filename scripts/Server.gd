class_name Server
extends Node

const MAX_PLAYERS = 300

# owner's id -> room name
var games := {} setget set_games

# owner's id -> owner's deck
var decks := {}

# id of all players that are in the lobby
var in_lobby = []

signal games_updated(games)

func _ready() -> void:
	if Args.is_server:
		start_server()
	else:
		start_client()

# Client
func start_client():
	var network := NetworkedMultiplayerENet.new()
	var err = network.create_client(Args.ip, Args.port)
	print("Connection to the server at %s:%d (return code %d)" % [Args.ip, Args.port, err])
	get_tree().set_network_peer(network)
	get_tree().connect("connected_to_server", self, "connected_to_server")
	get_tree().connect("connection_failed", self, "connection_failed")
	get_tree().connect("server_disconnected", self, "server_disconnected")

# Client
func connected_to_server():
	print("Connected to server!")

# Client
func connection_failed():
	print("Connection failed")

# Client
func server_disconnected():
	print("Server disconnected")


# Client
remote func set_games(new_games):
	games = new_games
	emit_signal("games_updated", games)

# Server
func start_server():
	var network := NetworkedMultiplayerENet.new()
	var err = network.create_server(Args.port, MAX_PLAYERS)
	get_tree().set_network_peer(network)
	get_tree().connect("network_peer_connected", self, "player_connected")
	get_tree().connect("network_peer_disconnected", self, "player_disconnected")
	print("Server created with port %d (return code %d)" % [Args.port, err])

# Server
func player_connected(id: int):
	print("Player %d connected" % id)
	rpc_id(id, "set_games", games)
	in_lobby.append(id)

# Server
func player_disconnected(id: int):
	print("Player %d disconnected" % id)
	games.erase(id)
	decks.erase(id)
	in_lobby.erase(id)
	for in_lobby_id in in_lobby:
		rpc_id(in_lobby_id, "set_games", games)

# Server
remote func create_game(name: String, deck: Array):
	var sender = get_tree().get_rpc_sender_id()
	games[sender] = name
	decks[sender] = deck
	for id in in_lobby:
		rpc_id(id, "set_games", games)

# Server
# Connects to the game owned by player id, with the deck deck2
remote func connect_to_game(id: int, deck2: Array):
	var id2 : int = get_tree().get_rpc_sender_id()
	var deck1: Array = decks[id]

	deck1.shuffle()
	deck2.shuffle()

	games.erase(id)
	decks.erase(id)
	in_lobby.erase(id)
	in_lobby.erase(id2)
	for id in in_lobby:
		rpc_id(id, "set_games", games)

	var game_decks = {id: deck1, id2: deck2}
	rpc_id(id, "start_game", game_decks)
	rpc_id(id2, "start_game", game_decks)

remote func start_game(game_decks: Dictionary):
	var GameScene = load("res://scenes/Game.tscn")
	var game = GameScene.instance()
	# game.name = "game_%d_%d" % [id, id2]
	get_tree().get_root().add_child(game)
	game.setup(game_decks)
	get_node("/root/online_menu").queue_free()
	queue_free()
