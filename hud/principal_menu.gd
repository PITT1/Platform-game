extends Control

@export var page_1_credits: PackedScene

@onready var button_jugar: Button = $textureRect/VBoxContainer/Button_jugar
@onready var button_options: Button = $textureRect/VBoxContainer/Button_options
@onready var button_credits: Button = $textureRect/VBoxContainer/button_credits
@onready var button_salir: Button = $textureRect/VBoxContainer/Button_salir

func  _ready() -> void:
	var lang = SaveGameProcesor.translate
	SaveGameProcesor.init_save_game()
	var selected_language = "en"
	if selected_language == "es":
		button_jugar.set_text(lang.principal_menu.btn_play.es)
		button_options.set_text(lang.principal_menu.btn_options.es)
		button_credits.set_text(lang.principal_menu.btn_credits.es)
		button_salir.set_text(lang.principal_menu.btn_quit.es)
	elif selected_language == "en":
		button_jugar.set_text(lang.principal_menu.btn_play.en)
		button_options.set_text(lang.principal_menu.btn_options.en)
		button_credits.set_text(lang.principal_menu.btn_credits.en)
		button_salir.set_text(lang.principal_menu.btn_quit.en)
		
		
func _on_button_jugar_button_up() -> void:
	get_tree().change_scene_to_file("res://hud/menu_levels.tscn")


func _on_button_salir_button_up() -> void:
	get_tree().quit()


func _on_button_button_up() -> void:
	var instantia = page_1_credits.instantiate()
	add_child(instantia)
