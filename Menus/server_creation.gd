extends Control

signal on_back
signal on_create

@export var port_edit: LineEdit

func _on_back_button_pressed():
	on_back.emit()


func _on_start_button_pressed():
	var port = port_edit.text if not port_edit.text.is_empty() else port_edit.placeholder_text
	if port.is_valid_int():
		on_create.emit(port.to_int())
