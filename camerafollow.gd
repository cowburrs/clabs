extends Camera2D

# I don't know if this is how it's supposed to work but here are the variables I guess 




# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_local_mouse_position()
	
	
	
	# print(get_global_mouse_position())
	pass
