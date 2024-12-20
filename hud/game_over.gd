extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var label: Label = $CanvasLayer/ColorRect/VBoxContainer/Label
@onready var btn_try_again: Button = $CanvasLayer/ColorRect/VBoxContainer/btn_try_again
@onready var btn_to_init_menu: Button = $CanvasLayer/ColorRect/VBoxContainer/btn_to_init_menu
@onready var btn_quit: Button = $CanvasLayer/ColorRect/VBoxContainer/btn_quit

var is_show: bool = false
func _ready() -> void:
	var lang = SaveGameProcesor.load_language()
	if lang == "spanish":
		label.set_text(SaveGameProcesor.translate.game_over_hud.title_labe.es)
		btn_try_again.set_text(SaveGameProcesor.translate.game_over_hud.try_agai_btn.es)
		btn_to_init_menu.set_text(SaveGameProcesor.translate.game_over_hud.go_to_main_menu.es)
		btn_quit.set_text(SaveGameProcesor.translate.game_over_hud.quit.es)
	elif lang == "english":
		label.set_text(SaveGameProcesor.translate.game_over_hud.title_labe.en)
		btn_try_again.set_text(SaveGameProcesor.translate.game_over_hud.try_agai_btn.en)
		btn_to_init_menu.set_text(SaveGameProcesor.translate.game_over_hud.go_to_main_menu.en)
		btn_quit.set_text(SaveGameProcesor.translate.game_over_hud.quit.en)


func showHud(show_hud: bool):
	if show_hud == true and is_show == false:
		animation_player.play("game_over_input")
		is_show = true
	elif show_hud == false and is_show == true:
		animation_player.play("game_over_out")
		is_show = false

func _on_btn_quit_button_up() -> void:
	get_tree().quit()


func _on_btn_to_init_menu_button_up() -> void:
	get_tree().change_scene_to_file("res://hud/principalMenu.tscn")


func _on_btn_try_again_button_up() -> void:
	get_tree().reload_current_scene()
