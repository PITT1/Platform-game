extends Control




func _on_button_jugar_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/tutorial.tscn")


func _on_button_salir_button_up() -> void:
	get_tree().quit()
