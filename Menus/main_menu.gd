extends CenterContainer

signal on_join
signal on_create

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_button_pressed():
	get_tree().quit()


func _on_create_button_pressed():
	on_create.emit()


func _on_join_button_pressed():
	on_join.emit()
