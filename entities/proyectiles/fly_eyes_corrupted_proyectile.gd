extends Node2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D

var velocity: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("in")
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if anim.get_animation() == "destroy":
		position += Vector2.ZERO
		collision.set_disabled(true)
	else:
		position += velocity * delta


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "in":
		anim.play("fly")
	
	if anim.get_animation() == "destroy":
		queue_free()
		

func _on_timer_timeout() -> void:
	anim.play("destroy")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		body.lives -= 1
		body.gettingHit = true
		anim.play("destroy")
	else:
		anim.play("destroy")
