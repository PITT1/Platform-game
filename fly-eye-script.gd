extends CharacterBody2D

@onready var flyEye: CharacterBody2D = $"."
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var player: CharacterBody2D = null
var playerLocationX: float
var playerLocationY: float
var flyEyeLocationX: float
var flyEyeLocationY: float
@export var speed: float = 60
@export var lives: int = 1
@export var aceleration: float = 1
var gettingHit = false
var death = false

func _ready() -> void:
	anim.play("flight")


func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null


func _process(delta: float) -> void:
	if player != null and not death:
		playerLocationX = player.global_position.x
		playerLocationY = player.global_position.y
		flyEyeLocationX = flyEye.global_position.x
		flyEyeLocationY = flyEye.global_position.y
		
		if playerLocationX > flyEyeLocationX:
			velocity.x += aceleration
			anim.flip_h = false
			if velocity.x > speed:
				velocity.x = speed
		else:
			velocity.x -= aceleration
			anim.flip_h = true
			if velocity.x < -speed:
				velocity.x = -speed
			
		if playerLocationY > flyEyeLocationY:
			velocity.y += aceleration
			if velocity.y > speed:
				velocity.y = speed
		else:
			velocity.y -= aceleration
			if velocity.y < -speed:
				velocity.y = -speed
			
		if lives == 0:
			death = true
			anim.play("death")
			await get_tree().create_timer(0.5).timeout
			flyEye.queue_free()
			
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
