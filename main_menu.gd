extends Control

signal on_start
signal on_quit

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus.call_deferred()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	on_start.emit()


func _on_quit_pressed():
	on_quit.emit()
