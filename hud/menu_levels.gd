extends Control



func _on_tutorial_btn_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/tutorial.tscn")


func _on_nivel_1_btn_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/world.tscn")


func _on_nivel_2_btn_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/world4.tscn")


func _on_nivel_3_btn_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/world2.tscn")


func _on_back_button_up() -> void:
	get_tree().change_scene_to_file("res://hud/principalMenu.tscn")


func _on_nivel_4_btn_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/world5.tscn")


func _on_nivel_5_btn_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/world6.tscn")
