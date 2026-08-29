extends Control
@onready var pause_menu: Control = $"."
@onready var options_panel: Panel = $"options panel"

func resume():
	get_tree() .paused = false
	$transition.play_backwards("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	get_tree() .paused = true
	$transition.play("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func testEsc():
	if Input.is_action_just_pressed("esc"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed() -> void:
	$PanelContainer/VBoxContainer/click.play()
	resume()

func _on_quit_pressed() -> void:
	$PanelContainer/VBoxContainer/click.play()
	get_tree().quit()
	
func _process(delta):
	testEsc()
	
func _ready():
	options_panel.visible = false


func _on_settings_pressed() -> void:
	$PanelContainer/VBoxContainer/click.play()
	options_panel.visible = true


func _on_back_pressed() -> void:
	$PanelContainer/VBoxContainer/click.play()
	options_panel.visible = false


func _on_resume_mouse_entered() -> void:
	$PanelContainer/VBoxContainer/hover.play()



func _on_settings_mouse_entered() -> void:
	$PanelContainer/VBoxContainer/hover.play()
	


func _on_back_mouse_entered() -> void:
	$PanelContainer/VBoxContainer/hover.play()


func _on_quit_mouse_entered() -> void:
	$PanelContainer/VBoxContainer/hover.play()
