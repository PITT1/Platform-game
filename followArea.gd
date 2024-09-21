extends Area2D

@onready var skeleton = $".."


func _on_body_exited(body) -> void:
	if body.get_position_delta().x > 0:
		skeleton.isRight = true
	else:
		skeleton.isRight = false
