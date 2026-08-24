extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.

#inputs

func _input(event):
	if event is InputEventMouseButton:
		if event.button_mask & MOUSE_BUTTON_MASK_RIGHT:
			print("RightMouseButton is clicked")
			
	if event is InputEventMouseButton:
		if event.button_mask & MOUSE_BUTTON_MASK_LEFT:
			print("LeftMouseButton is clicked")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
