class_name Anomaly
extends CharacterBody3D

@export var girls: Array[CompressedTexture2D]
var killed: int = 0


func _ready() -> void:
	var sprite_3d = $Sprite3D
	sprite_3d.texture = girls.pick_random()
	pass # Replace with function body.


func _process(delta: float) -> void:
	if $CollisionShape3D.disabled == true and randf() < 0.1 * delta:
		$Sprite3D.texture = girls.pick_random()
		$Sprite3D.visible = true
		$CollisionShape3D.disabled = false
		pass
	pass


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
	var factor = 6
	for x in range(1, w / factor):
		x = x * factor
		for y in range(1, h / factor):
			y = y * factor
			if randf() > 0.6:
				if img.get_pixel(x, y).a > 0:
					img.fill_rect(Rect2i(x, y, factor + 2, factor + 2), red) #(x, y, red)
	return ImageTexture.create_from_image(img)


func shot() -> int:
	var sprite_3d = $Sprite3D
	sprite_3d.texture = mosaic_texture(add_red_spots(sprite_3d.texture), 64)
	killyourself()
	killed += 1
	return killed

func killyourself() -> void:
	var sprite_3d = $Sprite3D
	await get_tree().create_timer(2.0).timeout
	sprite_3d.visible = false
	$CollisionShape3D.disabled = true

func get_camera_pos():
	var camera: Camera3D = get_viewport().get_camera_3d()

	if camera:
		return camera.unproject_position(global_position)
	else:
		return null


func _physics_process(delta: float) -> void:
	pass
