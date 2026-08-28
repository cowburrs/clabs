class_name Anomaly
extends CharacterBody3D

@export var girls: Array[CompressedTexture2D]


func _ready() -> void:
	var sprite_3d = $Sprite3D
	sprite_3d.texture = girls.pick_random()
	pass # Replace with function body.


func shot() -> void:
	var sprite_3d = $Sprite3D
	sprite_3d.visible = false
	await get_tree().create_timer(2.0).timeout
	sprite_3d.texture = girls.pick_random()
	sprite_3d.visible = true
	pass


func get_camera_pos():
	var camera: Camera3D = get_viewport().get_camera_3d()

	if camera:
		return camera.unproject_position(global_position)
	else:
		return null


func _physics_process(delta: float) -> void:
	pass
