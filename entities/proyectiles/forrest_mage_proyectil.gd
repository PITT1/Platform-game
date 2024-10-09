extends RigidBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("in")


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "in":
		anim.play("fly")
		
	if anim.get_animation() == "out":
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		anim.play("out")
		body.lives -= 1
		body.gettingHit = true
	else:
		anim.play("out")
