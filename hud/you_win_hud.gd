extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var label: Label = $CanvasLayer/ColorRect/VBoxContainer/Label
@onready var next_level_btn: Button = $CanvasLayer/ColorRect/VBoxContainer/next_level_btn
@onready var try_again_btn: Button = $CanvasLayer/ColorRect/VBoxContainer/try_again_btn
@onready var go_to_menu_levels_btn: Button = $CanvasLayer/ColorRect/VBoxContainer/go_to_menu_levels_btn
@onready var quit_btn: Button = $CanvasLayer/ColorRect/VBoxContainer/quit_btn

var is_show: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lang = SaveGameProcesor.load_language()
	if lang == "spanish":
		label.set_text(SaveGameProcesor.translate.you_win_hud.title_label.es)
		next_level_btn.set_text(SaveGameProcesor.translate.you_win_hud.next_level.es)
		try_again_btn.set_text(SaveGameProcesor.translate.you_win_hud.try_agai_btn.es)
		go_to_menu_levels_btn.set_text(SaveGameProcesor.translate.you_win_hud.go_to_menu_levels.es)
		quit_btn.set_text(SaveGameProcesor.translate.you_win_hud.quit.es)
	elif lang == "english":
		label.set_text(SaveGameProcesor.translate.you_win_hud.title_label.en)
		next_level_btn.set_text(SaveGameProcesor.translate.you_win_hud.next_level.en)
		try_again_btn.set_text(SaveGameProcesor.translate.you_win_hud.try_agai_btn.en)
		go_to_menu_levels_btn.set_text(SaveGameProcesor.translate.you_win_hud.go_to_menu_levels.en)
		quit_btn.set_text(SaveGameProcesor.translate.you_win_hud.quit.en)
	



func showHud(show_hud: bool):
	if show_hud == true and is_show == false:
		animation_player.play("victory_in")
		get_tree().paused = true
		is_show = true
	elif show_hud == false and is_show == true:
		animation_player.play("victory_out")
		is_show = false


func _on_quit_btn_button_up() -> void:
	get_tree().paused = false
	get_tree().quit()


func _on_go_to_menu_levels_btn_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://hud/menu_levels.tscn")


func _on_try_again_btn_button_up() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_next_level_btn_button_up() -> void:
	if get_parent().name == "tutorial":
		get_tree().paused = false
		var data = JSON.parse_string(SaveGameProcesor.load_data())
		get_tree().change_scene_to_file(data["level_1"]["level_path"])
	else:
		get_tree().paused = false
		var current_level = get_parent().name
		var current_level_split = current_level.split("_")
		var num_next_level = int(current_level_split[1]) + 1
		var next_level_path = "res://levels/escene_levels/world_" + str(num_next_level) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
