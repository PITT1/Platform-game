extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var resume_sound: AudioStreamPlayer = $resume_sound


func _ready() -> void:
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
