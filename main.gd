extends Node3D

@onready var debug_cam := $Camera3D

var menu_scene := preload("res://main_menu.tscn")
var menu = menu_scene.instantiate()

var level_scene := preload("res://level.tscn")
var level: Node3D

@onready var world := $World

# Called when the node enters the scene tree for the first time.
func _ready():
	world.add_child(menu)
	menu.on_start.connect(_on_start)
	menu.on_quit.connect(_on_quit)

func _on_start():
	level = level_scene.instantiate()
	_swap_scene.call_deferred(menu, level)
	$Camera3D.clear_current.call_deferred()

func _on_quit():
	get_tree().quit()
	
	
func _swap_scene(old: Node, new: Node):
	old.free()
	world.add_child(new)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("debug_cam"):
		if (debug_cam.current):
			debug_cam.clear_current()
		else:
			debug_cam.make_current()
		
