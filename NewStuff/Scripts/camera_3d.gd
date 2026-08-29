extends Camera3D

@onready var AnimPlayer = $AnimationPlayer

var zoomed = false
const speed = 0.01
const default_size = 20
const default_size_zoomed = 5
var real_position: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	fov = default_size
	real_position = Vector2(position.x, position.y)
	pass # Replace with function body.


func zoommove(spd: int, csize: int, delta: float) -> void:
	var x = real_position.x - position.x
	var y = real_position.y - position.y
	fov += (csize - fov) * delta * spd
	position += Vector3(x, y, 0) * delta * spd
	real_position.x = clamp(real_position.x, -12, 12)
	real_position.y = clamp(real_position.y, -4, 10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if zoomed:
		zoommove(15, default_size_zoomed, delta)
	else:
		zoommove(5, default_size, delta)
	pass


func _input(event):
	#if event is InputEventMouseMotion:
	#translate(Vector3(event.relative.x * speed, 0, 0))
	if event.is_action_pressed("right_click") and zoomed == false:
		zoomed = !zoomed
		AnimPlayer.play("Zoom")
	elif event.is_action_pressed("right_click") and zoomed == true:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		zoomed = !zoomed
		AnimPlayer.play_backwards("Zoom")

	if event is InputEventMouseMotion == true:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		real_position += Vector2(event.relative.x * speed, -event.relative.y * speed)

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
	var collider = raycast_result.get("collider")
	if (collider is Anomaly) and (zoomed):
		collider.shot()
