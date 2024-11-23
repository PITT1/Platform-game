extends RigidBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var velocity: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("in")
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "in":
		anim.play("fly")
	
	if anim.get_animation() == "destroy":
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		body.lives -= 1
		body.gettingHit = true
		anim.play("destroy")
	elif body.name == "TileMap":
		anim.play("destroy")


func _on_timer_timeout() -> void:
	anim.play("destroy")
