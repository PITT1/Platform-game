extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var resume_sound: AudioStreamPlayer = $resume_sound

@onready var label: Label = $CanvasLayer/ColorRect/VBoxContainer/Label
@onready var resume_btn: Button = $CanvasLayer/ColorRect/VBoxContainer/resume_btn
@onready var options: Button = $CanvasLayer/ColorRect/VBoxContainer/options
@onready var main_menu: Button = $CanvasLayer/ColorRect/VBoxContainer/main_menu
@onready var quit: Button = $CanvasLayer/ColorRect/VBoxContainer/quit


func _ready() -> void:
	var lang = SaveGameProcesor.load_language()
	if lang == "spanish":
		label.set_text(SaveGameProcesor.translate.pause_menu.title.es)
		resume_btn.set_text(SaveGameProcesor.translate.pause_menu.resume_btn.es)
		options.set_text(SaveGameProcesor.translate.pause_menu.options_btn.es)
		main_menu.set_text(SaveGameProcesor.translate.pause_menu.menu_levels_btn.es)
		quit.set_text(SaveGameProcesor.translate.pause_menu.quit.es)
	elif lang == "english":
		label.set_text(SaveGameProcesor.translate.pause_menu.title.en)
		resume_btn.set_text(SaveGameProcesor.translate.pause_menu.resume_btn.en)
		options.set_text(SaveGameProcesor.translate.pause_menu.options_btn.en)
		main_menu.set_text(SaveGameProcesor.translate.pause_menu.menu_levels_btn.en)
		quit.set_text(SaveGameProcesor.translate.pause_menu.quit.en)
	animation_player.play("pause_in")



func _on_resume_btn_button_up() -> void:
	animation_player.play("pause_out")
	resume_sound.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pause_out":
		get_tree().paused = false
		queue_free()


func _on_main_menu_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://hud/menu_levels.tscn")


func _on_quit_button_up() -> void:
	get_tree().paused = false
	get_tree().quit()
