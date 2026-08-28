extends Camera3D

@onready var AnimPlayer = $AnimationPlayer



var zoomed = false
const speed = 0.01
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	#if event is InputEventMouseMotion:
		#translate(Vector3(event.relative.x * speed, 0, 0))
	if event.is_action_pressed("right_click") and zoomed == false:
		size = 5
		zoomed = !zoomed
		AnimPlayer.play("Zoom")
	elif event.is_action_pressed("right_click") and zoomed == true:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		size = 30
		position = Vector3(0.000, 1.593, 0.018)
		zoomed = !zoomed
		AnimPlayer.play_backwards("Zoom")
	
	if event is InputEventMouseMotion and zoomed == true:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			translate(Vector3(event.relative.x * speed, -event.relative.y * speed, 0))
	
	if event.is_action_pressed("left_click"):
		shoot_ray()
	pass

func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	print(raycast_result)
	
