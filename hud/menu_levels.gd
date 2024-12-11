extends Control

@onready var nivel_1_btn: Button = $ColorRect/VBoxContainer/nivel_1_btn
@onready var nivel_2_btn: Button = $ColorRect/VBoxContainer/nivel_2_btn
@onready var nivel_3_btn: Button = $ColorRect/VBoxContainer/nivel_3_btn
@onready var nivel_4_btn: Button = $ColorRect/VBoxContainer/nivel_4_btn
@onready var nivel_5_btn: Button = $ColorRect/VBoxContainer/nivel_5_btn

var level_config_path: String = "res://levels/level_config/level_config.json"

func _ready() -> void:
	var file = FileAccess.open(level_config_path,FileAccess.READ)
	var parsed_file = JSON.parse_string(file.get_as_text())
	if parsed_file.level_1.is_level_bloqued:
		nivel_1_btn.set_disabled(true)
	else:
		nivel_1_btn.set_disabled(false)
	
	if parsed_file.level_2.is_level_bloqued:
		nivel_2_btn.set_disabled(true)
	else:
		nivel_2_btn.set_disabled(false)
	
	if parsed_file.level_3.is_level_bloqued:
		nivel_3_btn.set_disabled(true)
	else:
		nivel_3_btn.set_disabled(false)
	
	if parsed_file.level_4.is_level_bloqued:
		nivel_4_btn.set_disabled(true)
	else:
		nivel_4_btn.set_disabled(false)
	
	if parsed_file.level_5.is_level_bloqued:
		nivel_5_btn.set_disabled(true)
	else:
		nivel_5_btn.set_disabled(false)
	
	file.close()

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
