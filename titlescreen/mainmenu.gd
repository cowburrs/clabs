extends MarginContainer

@export
var TEST: PackedScene

@onready var main_menu: HBoxContainer = $"main menu"
@onready var options_panel: Panel = $"options panel"

func _ready():
	main_menu.visible = true
	options_panel.visible = false

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
