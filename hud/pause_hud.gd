extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("pause_in")


func _process(delta: float) -> void:
	pass


func _on_resume_btn_button_up() -> void:
	animation_player.play("pause_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pause_out":
		queue_free()
