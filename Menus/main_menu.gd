extends Control

signal on_join
signal on_create

func _on_quit_button_pressed():
	get_tree().quit()


func _on_create_button_pressed():
	on_create.emit()


func _on_join_button_pressed():
	on_join.emit()
