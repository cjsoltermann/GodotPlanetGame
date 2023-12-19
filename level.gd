extends Node3D

var character_scene := preload("res://character.tscn")
@onready var player_root := $Players

@onready var planets: Node3D = $Planets

var server: Server

func add_character(id: int):
	var character = character_scene.instantiate()
	character.id = id
	character.name = "Player%s" % id
	
	character.get_gravity = func (pos: Vector3) -> Vector3:
		var ret := Vector3.ZERO
		for planet: Planet in planets.get_children():
			var dir := planet.position - pos
			ret += dir * (planet.mass / dir.length_squared())
		return ret
		
	character.get_closest_body = func (pos: Vector3) -> Node3D:
		var dist := INF
		var ret := planets.get_child(0)
		for planet: Planet in planets.get_children():
			var d := (planet.position - pos).length_squared()
			if (d < dist):
				dist = d
				ret = planet
		return ret
	
	player_root.add_child(character, true)


# Called when the node enters the scene tree for the first time.
func _ready():
	add_character(multiplayer.get_unique_id())
	for id in multiplayer.get_peers():
		add_character(id)
		
	server.on_player_connected.connect(add_character)
