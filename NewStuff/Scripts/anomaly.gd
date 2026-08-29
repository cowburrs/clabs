class_name Anomaly
extends CharacterBody3D

@export var girls: Array[CompressedTexture2D]
var image_blood: Texture2D
var image_normal: Texture2D


func _ready() -> void:
	var sprite_3d = $Sprite3D
	sprite_3d.texture = girls.pick_random()
	image_blood = mosaic_texture(add_red_spots($Sprite3D.texture), 64)
	image_normal = $Sprite3D.texture
	pass # Replace with function body.


func mosaic_texture(tex: Texture2D, pixel_size: int) -> Texture2D:
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


func add_red_spots(tex: Texture2D) -> Texture2D:
	var img: Image = tex.get_image()
	if img.is_compressed():
		img.decompress()
	var w: int = img.get_width()
	var h: int = img.get_height()
	var red: Color = Color(1, 0, 0, 1)
	for x in range(1, w):
		for y in range(1, h):
			if randf() > 0.5:
				if img.get_pixel(x, y).a > 0:
					img.set_pixel(x, y, red)
	return ImageTexture.create_from_image(img)


func shot() -> void:
	print("shot")
	var sprite_3d = $Sprite3D
	sprite_3d.texture = image_blood
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
