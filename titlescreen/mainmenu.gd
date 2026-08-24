extends MarginContainer
@export
var nextscene: PackedScene

const nextscene = preload("res://node_2d.tscn")

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(nextscene)
	pass # Replace with function body.

func _on_config_pressed() -> void:
	pass # Replace with function body.
	

func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
