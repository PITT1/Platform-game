extends Control

@onready var label: Label = $ColorRect/VBoxContainer/Label
@onready var nivel_1_btn: Button = $ColorRect/VBoxContainer/nivel_1_btn
@onready var nivel_2_btn: Button = $ColorRect/VBoxContainer/nivel_2_btn
@onready var nivel_3_btn: Button = $ColorRect/VBoxContainer/nivel_3_btn
@onready var nivel_4_btn: Button = $ColorRect/VBoxContainer/nivel_4_btn
@onready var nivel_5_btn: Button = $ColorRect/VBoxContainer/nivel_5_btn
@onready var nivel_6_btn: Button = $ColorRect/VBoxContainer/nivel_6_btn
@onready var back: Button = $ColorRect/back

var data_load: String
var data_json
@export var all_levels_unlock = false

func _ready() -> void:
	data_load = SaveGameProcesor.load_data()
	data_json = JSON.parse_string(data_load)
	var lang = SaveGameProcesor.load_language()
	if lang == "spanish":
		label.set_text(SaveGameProcesor.translate.menu_levels.label_title.es)
		nivel_1_btn.set_text(SaveGameProcesor.translate.menu_levels.level_1.es)
		nivel_2_btn.set_text(SaveGameProcesor.translate.menu_levels.level_2.es)
		nivel_3_btn.set_text(SaveGameProcesor.translate.menu_levels.level_3.es)
		nivel_4_btn.set_text(SaveGameProcesor.translate.menu_levels.level_4.es)
		nivel_5_btn.set_text(SaveGameProcesor.translate.menu_levels.level_5.es)
		nivel_6_btn.set_text(SaveGameProcesor.translate.menu_levels.level_6.es)
		back.set_text(SaveGameProcesor.translate.menu_levels.btn_back.es)
	elif lang == "english":
		label.set_text(SaveGameProcesor.translate.menu_levels.label_title.en)
		nivel_1_btn.set_text(SaveGameProcesor.translate.menu_levels.level_1.en)
		nivel_2_btn.set_text(SaveGameProcesor.translate.menu_levels.level_2.en)
		nivel_3_btn.set_text(SaveGameProcesor.translate.menu_levels.level_3.en)
		nivel_4_btn.set_text(SaveGameProcesor.translate.menu_levels.level_4.en)
		nivel_5_btn.set_text(SaveGameProcesor.translate.menu_levels.level_5.en)
		nivel_6_btn.set_text(SaveGameProcesor.translate.menu_levels.level_6.en)
		back.set_text(SaveGameProcesor.translate.menu_levels.btn_back.en)
	
	if not all_levels_unlock == true:	
		if data_json.level_1.is_level_blocked:
			nivel_1_btn.set_disabled(true)
		else:
			nivel_1_btn.set_disabled(false)
	
		if data_json.level_2.is_level_blocked:
			nivel_2_btn.set_disabled(true)
		else:
			nivel_2_btn.set_disabled(false)
	
		if data_json.level_3.is_level_blocked:
			nivel_3_btn.set_disabled(true)
		else:
			nivel_3_btn.set_disabled(false)
	
		if data_json.level_4.is_level_blocked:
			nivel_4_btn.set_disabled(true)
		else:
			nivel_4_btn.set_disabled(false)
	
		if data_json.level_5.is_level_blocked:
			nivel_5_btn.set_disabled(true)
		else:
			nivel_5_btn.set_disabled(false)
	
		if data_json.level_6.is_level_blocked:
			nivel_6_btn.set_disabled(true)
		else:
			nivel_6_btn.set_disabled(false)



func _on_tutorial_btn_button_up() -> void:
	var level = data_json.tutorial.level_path
	get_tree().change_scene_to_file(level)


func _on_nivel_1_btn_button_up() -> void:
	var level = data_json.level_1.level_path
	get_tree().change_scene_to_file(level)


func _on_nivel_2_btn_button_up() -> void:
	var level = data_json.level_2.level_path
	get_tree().change_scene_to_file(level)


func _on_nivel_3_btn_button_up() -> void:
	var level = data_json.level_3.level_path
	get_tree().change_scene_to_file(level)


func _on_back_button_up() -> void:
	get_tree().change_scene_to_file("res://hud/principalMenu.tscn")


func _on_nivel_4_btn_button_up() -> void:
	var level = data_json.level_4.level_path
	get_tree().change_scene_to_file(level)


func _on_nivel_5_btn_button_up() -> void:
	var level = data_json.level_5.level_path
	get_tree().change_scene_to_file(level)


func _on_nivel_6_btn_button_up() -> void:
	var level = data_json.level_6.level_path
	get_tree().change_scene_to_file(level)
