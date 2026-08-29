class_name Anomaly
extends CharacterBody3D

@export var girls: Array[CompressedTexture2D]


func _ready() -> void:
	var sprite_3d = $Sprite3D
	sprite_3d.texture = girls.pick_random()
	pass # Replace with function body.


func mosaic_texture(tex: Texture2D, pixel_size: int) -> ImageTexture:
	var img: Image = tex.get_image()
	if img.is_compressed():
		img.decompress()
	var w: int = img.get_width()
	var h: int = img.get_height()
	var small_w: int = max(1, int(w / float(pixel_size)))
	var small_h: int = max(1, int(h / float(pixel_size)))
	img.resize(small_w, small_h, Image.INTERPOLATE_BILINEAR)
	img.resize(w, h, Image.INTERPOLATE_NEAREST)
	return ImageTexture.create_from_image(img)


func shot() -> void:
	print("shot")
	$Sprite3D.texture = mosaic_texture($Sprite3D.texture, 64)
	var sprite_3d = $Sprite3D
	# sprite_3d.visible = false
	await get_tree().create_timer(2.0).timeout
	# sprite_3d.texture = girls.pick_random()
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
