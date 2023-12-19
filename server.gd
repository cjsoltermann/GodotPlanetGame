class_name Server
extends Node

signal on_player_connected(id: int)
signal on_player_disconnected(id: int)

func start_server(port: int):
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		push_error("Failed to create a server!")
		return
	get_parent().multiplayer.multiplayer_peer = peer
	
func join_server(ip: String, port: int):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		push_error("Failed to connect to server!")
		return
	get_parent().multiplayer.multiplayer_peer = peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(id):
	on_player_connected.emit(id)
	
func _on_peer_disconnected(id):
	on_player_disconnected.emit(id)
