extends Node3D

@onready var server: Server = $Server
@onready var debug_cam := $Camera3D

var menu_scene := preload("res://Menus/root_menu.tscn")
var menu := menu_scene.instantiate()

var level_scene := preload("res://level.tscn")
var level: Node3D

var current_scene: Node = menu

@onready var world := $World

# Called when the node enters the scene tree for the first time.
func _ready():
	world.add_child(menu)
	menu.on_create.connect(_on_create_server)
	menu.on_join.connect(_on_join_server)
	
func _start_level():
	level = level_scene.instantiate()
	_swap_scene.call_deferred(level)
	debug_cam.clear_current.call_deferred()
	
func _on_create_server(port: int):
	server.start_server(port)
	_start_level()
	
func _on_join_server(address: String, port: int):
	server.join_server(address, port)
	_start_level()

func _on_quit():
	get_tree().quit()
	
func _swap_scene(new: Node, free_old: bool = true):
	if (free_old):
		current_scene.free()
	else:
		world.remove_child(current_scene)
		
	world.add_child(new)
	current_scene = new

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("debug_cam"):
		if (debug_cam.current):
			debug_cam.clear_current()
		else:
			debug_cam.make_current()
		
