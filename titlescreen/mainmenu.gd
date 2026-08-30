extends MarginContainer

@export
var TEST: PackedScene

@onready var main_menu: HBoxContainer = $"main menu"
@onready var options_panel: Panel = $"options panel"

func _ready():
	main_menu.visible = true
	options_panel.visible = false
	$mainmenumusic.play
	$"options panel/audio slider".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	$"options panel/bgm".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")))

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(TEST)
	$press.play()


func _on_optiosn_pressed() -> void:
	main_menu.visible = false
	options_panel.visible = true
	$press.play()


func _on_quit_pressed() -> void:
	get_tree().quit()
	$press.play()


func _on_back_pressed() -> void:
	main_menu.visible = true
	options_panel.visible = false
	$press.play()


func _on_new_game_mouse_entered() -> void:
	$hover.play()


func _on_optiosn_mouse_entered() -> void:
	$hover.play()


func _on_quit_mouse_entered() -> void:
	$hover.play()


func _on_back_mouse_entered() -> void:
	$hover.play()


func _on_audio_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_bgm_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), linear_to_db(value))


func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_endless_button_pressed() -> void:
	Gamestate.mode = Gamestate.Mode.ENDLESS
	get_tree().change_scene_to_packed(TEST)
	$press.play()
