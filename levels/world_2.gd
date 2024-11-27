extends Node2D
@export var is_level_pass: bool = false 

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body:
		is_level_pass = true
