extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("flight")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
