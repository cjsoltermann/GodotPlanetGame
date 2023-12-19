extends Control

signal on_back
signal on_join

@export var port_edit: LineEdit
@export var address_edit: LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	var port = port_edit.text if not port_edit.text.is_empty() else port_edit.placeholder_text
	var address = address_edit.text if not address_edit.text.is_empty() else address_edit.placeholder_text
	if port.is_valid_int() and address.is_valid_ip_address():
		on_join.emit(address, port.to_int())


func _on_back_button_pressed():
	on_back.emit()
