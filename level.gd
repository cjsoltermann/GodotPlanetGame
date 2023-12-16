extends Node3D

@onready var character := $Character

@onready var planets: Array[Node3D] = [$Planet, $Planet2]

@onready var orbiting := $Planet2

# Called when the node enters the scene tree for the first time.
func _ready():
	character.get_gravity = func (pos: Vector3) -> Vector3:
		var ret := Vector3.ZERO
		for planet in planets:
			var dir := planet.position - pos
			ret += dir * (50.0 / dir.length_squared())
		return ret
		
	character.get_closest_body = func (pos: Vector3) -> Node3D:
		var dist := INF
		var ret := planets[0]
		for planet in planets:
			var d := (planet.position - pos).length_squared()
			if (d < dist):
				dist = d
				ret = planet
		return ret

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#orbiting.position.x = 50*cos(Time.get_ticks_usec() / 10000000.0)
	#orbiting.position.z = 50*sin(Time.get_ticks_usec() / 10000000.0)
