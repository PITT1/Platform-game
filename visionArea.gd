extends Area2D

@onready var skeleton = $".."
@onready var player_body = $CharacterBody2D
var player = "CharacterBody2D:<CharacterBody2D#55113155874>"


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.to_string() == player:
		if body.get_position_delta().x > 0:
			print("player a la izquierda")
			skeleton.inmove = true
			skeleton.isRight = false
		else:
			print("player a la derecha")
			skeleton.inmove = true
			skeleton.isRight = true
