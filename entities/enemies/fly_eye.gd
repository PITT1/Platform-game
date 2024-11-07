extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var player : CharacterBody2D = null
@export var speed: float = 60
@export var acceleration: float = 300

func _ready() -> void:
	anim.play("fly")

func _physics_process(delta: float) -> void:
	if player != null:
		movement(delta)
		
		
	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body

func movement(delta):
	if player.global_position.x > global_position.x:
		velocity += Vector2.RIGHT * acceleration * delta
		if velocity.x > speed:
			velocity.x = speed
				
	if player.global_position.x < global_position.x:
		velocity += Vector2.LEFT * acceleration * delta
		if velocity.x < -speed:
			velocity.x = -speed 
		
	if player.global_position.y > global_position.y:
		velocity += Vector2.DOWN * acceleration * delta
		if velocity.y > speed:
			velocity.y = speed
		
	if player.global_position.y < global_position.y:
		velocity += Vector2.UP * acceleration * delta
		if velocity.y < -speed:
			velocity.y = -speed
