class_name Character
extends CharacterBody3D

@onready var head := $Body/Neck/Head
@onready var camera: Camera3D = $Body/Neck/Head/Camera3D
@onready var body := $Body
@onready var input: CharacterInput = $CharacterInput

@export var id := 1

@export var speed := 10
@export var sprint_speed := 20
@export var jump_power := 25

var has_double: bool = true

var get_gravity: Callable
var get_closest_body: Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	set_multiplayer_authority(id)
	if id == multiplayer.get_unique_id():
		camera.make_current()
		body.hide()
	
	set_process(id == multiplayer.get_unique_id())
	set_physics_process(id == multiplayer.get_unique_id())
	set_process_input(id == multiplayer.get_unique_id())

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		#rotate_y(-event.relative.x / 100.0)
		rotate(basis.y, -event.relative.x / 150.0)
		head.rotate_x(event.relative.y / 150.0)
		orthonormalize()

func _physics_process(delta):
	apply_floor_snap()
	if get_gravity:
		var gravity: Vector3 = get_gravity.call(position)
		var closest_body : Node3D = get_closest_body.call(position)
		var down = (closest_body.position - position).normalized()
		velocity += gravity
		up_direction = -down
		
		var new_x := up_direction.cross(basis.z)
		var new_z := new_x.cross(up_direction)
		var new_quat := Basis(new_x, up_direction, new_z).get_rotation_quaternion()
		quaternion = quaternion.slerp(new_quat, 0.05)

	velocity -= basis.x * velocity.dot(basis.x)
	velocity -= basis.z * velocity.dot(basis.z)
	
	var cur_speed: float
	if Input.is_action_pressed("Sprint"):
		cur_speed = sprint_speed
	else:
		cur_speed = speed
	
	var dir := basis * input.dir
	
	dir *= cur_speed
	velocity += dir
	
	move_and_slide()
	
	if is_on_floor():
		has_double = true
	
func jump():
	if is_on_floor():
			velocity += jump_power * basis.y
	elif has_double:
		velocity += jump_power * basis.y
		has_double = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
