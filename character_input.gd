class_name CharacterInput
extends Node

@export var dir := Vector3.ZERO
@export var sprinting := false

@onready var character: Character = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	set_multiplayer_authority(character.id)
	set_process_input(character.id == multiplayer.get_unique_id())

func _input(event):
	if event.is_action_pressed("Release Mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	elif event.is_action_pressed("Forward"):
		dir.z = 1.0
	elif event.is_action_pressed("Backward"):
		dir.z = -1.0
	elif event.is_action_released("Forward") and not Input.is_action_pressed("Backward"):
		dir.z = 0.0
	elif event.is_action_released("Backward") and not Input.is_action_pressed("Forward"):
		dir.z = 0.0
	
	elif event.is_action_pressed("Left"):
		dir.x = 1.0	
	elif event.is_action_pressed("Right"):
		dir.x = -1.0
	elif event.is_action_released("Right") and not Input.is_action_pressed("Left"):
		dir.x = 0.0
	elif event.is_action_released("Left") and not Input.is_action_pressed("Right"):
		dir.x = 0.0
		
	elif event.is_action_pressed("Jump"):
		character.jump.rpc()
		
	elif event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		#rotate_y(-event.relative.x / 100.0)
		character.rotate(character.basis.y, -event.relative.x / 150.0)
		character.head.rotate_x(event.relative.y / 150.0)
		character.orthonormalize()
