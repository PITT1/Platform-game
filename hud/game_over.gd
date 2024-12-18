extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_show: bool = false
func _ready() -> void:
	pass



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
