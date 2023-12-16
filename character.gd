extends CharacterBody3D

@onready var head := $Body/Neck/Head

@export var speed := 10
@export var sprint_speed := 20
@export var jump_power := 25

var has_double: bool = true

var get_gravity: Callable
var get_closest_body: Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event.is_action_pressed("Release Mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
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
	
	var dir := Vector3.ZERO
	
	if Input.is_action_pressed("Forward"):
		#velocity += cur_speed * basis.z
		dir += basis.z
	elif Input.is_action_pressed("Backward"):
		#velocity -= cur_speed * basis.z
		dir -= basis.z
		
	if Input.is_action_pressed("Left"):
		#velocity += cur_speed * basis.x
		dir += basis.x
	elif Input.is_action_pressed("Right"):
		#velocity -= cur_speed * basis.x
		dir -= basis.x
		
	dir *= cur_speed
	velocity += dir
	
	move_and_slide()
	
	if is_on_floor():
		has_double = true
	
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity += jump_power * basis.y
		elif has_double:
			velocity += jump_power * basis.y
			has_double = false
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
