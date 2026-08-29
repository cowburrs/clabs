extends Camera3D

@export var cb: CharacterBody3D

var main_camera: Camera3D


func _ready() -> void:
	if cb:
		for child in cb.get_children():
			if child is Camera3D:
				main_camera = child
				break


func _process(_delta: float) -> void:
	print(position)
	if main_camera:
		global_transform = main_camera.global_transform
		fov = main_camera.fov
