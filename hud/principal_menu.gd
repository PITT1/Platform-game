extends Control

@export var page_1_credits: PackedScene

func  _ready() -> void:
	SaveGameProcesor.init_save_game()


func _on_button_jugar_button_up() -> void:
	get_tree().change_scene_to_file("res://hud/menu_levels.tscn")


func _on_button_salir_button_up() -> void:
	get_tree().quit()


func _on_button_button_up() -> void:
	var instantia = page_1_credits.instantiate()
	add_child(instantia)
