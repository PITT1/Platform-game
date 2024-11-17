extends StaticBody2D
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var text = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.set_text(text)


func _on_letter_area_body_entered(body: Node2D) -> void:
	if body:
		animation_player.play("show_message")


func _on_letter_area_body_exited(body: Node2D) -> void:
	if body:
		animation_player.play("hide_message")
