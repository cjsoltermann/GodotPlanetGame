extends Control

signal on_create
signal on_quit
signal on_join

var main_menu_scene := preload("res://Menus/main_menu.tscn")
var main_menu := main_menu_scene.instantiate()

var server_create_menu_scene := preload("res://Menus/server_creation.tscn")
var server_create_menu := server_create_menu_scene.instantiate()

var server_join_menu_scene := preload("res://Menus/server_selection.tscn")
var server_join_menu := server_join_menu_scene.instantiate()

@onready var menu_root: Node = $CurrentMenu
var current_menu: Node = main_menu

func _swap_menu(new: Node):
	menu_root.remove_child(current_menu)
	menu_root.add_child(new)
	current_menu = new

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus.call_deferred()
	menu_root.add_child(main_menu)
	main_menu.on_join.connect(_on_main_join)
	main_menu.on_create.connect(_on_main_create)
	
	server_create_menu.on_create.connect(func (): on_create.emit())
	
	server_join_menu.on_back.connect(_on_back)
	server_create_menu.on_back.connect(_on_back)

func _on_main_join():
	_swap_menu(server_join_menu)
	
func _on_main_create():
	_swap_menu(server_create_menu)
	
func _on_back():
	_swap_menu(main_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_create_button_pressed():
	on_create.emit()


func _on_join_button_pressed():
	on_join.emit()


func _on_quit_button_pressed():
	on_quit.emit()
