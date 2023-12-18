extends Control

signal on_back
signal on_create

@onready var port_edit: LineEdit = $CenterContainer/VBoxContainer/PortEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	on_back.emit()


func _on_start_button_pressed():
	if not port_edit.text.is_valid_int():
		return
	on_create.emit(port_edit.text.to_int())
