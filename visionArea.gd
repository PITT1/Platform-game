extends Area2D

@onready var skeleton = $".."

func _on_body_entered(body) -> void:
	if body.get_position_delta().x > 0:
		print("player a la izquierda")
		skeleton.inmove = true
		skeleton.isRight = false
	else:
		print("player a la derecha")
		skeleton.inmove = true
		skeleton.isRight = true
			
