extends Control

signal on_create
signal on_quit
signal on_join

@onready var main_menu := $MainMenu
@onready var server_create_menu := $ServerCreation
@onready var server_join_menu := $ServerSelection

@onready var current_menu := main_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	current_menu.show()
	
	main_menu.on_join.connect(_on_main_join)
	main_menu.on_create.connect(_on_main_create)
	
	server_create_menu.on_create.connect(_on_create_button_pressed)
	server_join_menu.on_join.connect(_on_join_button_pressed)
	
	server_join_menu.on_back.connect(_on_back)
	server_create_menu.on_back.connect(_on_back)

func _on_main_join():
	_show_menu(server_join_menu)
	
func _on_main_create():
	_show_menu(server_create_menu)
	
func _on_back():
	_show_menu(main_menu)
	
func _show_menu(menu):
	current_menu.hide()
	menu.show()
	current_menu = menu

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_create_button_pressed():
	on_create.emit()


func _on_join_button_pressed():
	on_join.emit()


func _on_quit_button_pressed():
	on_quit.emit()
