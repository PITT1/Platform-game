extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("page_in")



func _on_next_button_up() -> void:
	animation_player.play("page_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "page_out":
		queue_free()
