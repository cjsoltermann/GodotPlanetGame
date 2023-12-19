@tool
class_name Planet
extends AnimatableBody3D

@export var color := Color("40662a"):
	set(new_color):
		color = new_color
		if $Mesh:
			($Mesh.material as ShaderMaterial).set_shader_parameter("color", color)
			
@export var orbiting := false
@export var orbit_speed := 50.0
@export var mass := 25

func _ready():
	if Engine.is_editor_hint():
		pass
	if not Engine.is_editor_hint():
		pass

func _process(delta):
	if Engine.is_editor_hint():
		pass
	if not Engine.is_editor_hint():
		pass


func _physics_process(delta):
	if Engine.is_editor_hint():
		pass
	if not Engine.is_editor_hint():
		#var t = Time.get_ticks_usec() / 100000000.0
		#position = Vector3(orbit_speed*sin(t), orbit_speed*cos(t), 0)
		if orbiting:
			position += Vector3(orbit_speed*delta*-position.y, orbit_speed*delta*position.x, 0)
