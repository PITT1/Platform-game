extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var velocity = Vector2(0, 0)
var flyin = false
@onready var collision_area: CollisionShape2D = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("in")


func _process(delta: float) -> void:
	if flyin:
		position += velocity * delta

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "in":
		flyin = true
		anim.play("fly")
		
	if anim.get_animation() == "out":
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D" and not body.on_defense:
		anim.play("out")
		collision_area.set_disabled(true)
		body.velocity = global_position.direction_to(body.global_position) * 600
		body.lives -= 1
		body.gettingHit = true
	elif body.name == "CharacterBody2D" and body.on_defense:
		body.shield_block = true
		body.velocity = global_position.direction_to(body.global_position) * 300
	else:
		anim.play("out")
		collision_area.set_disabled(true)
	
	velocity = Vector2(0, 0)
