extends CharacterBody2D

@onready var flyEye: CharacterBody2D = $"."
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var player: CharacterBody2D = null
var playerLocationX
var playerLocationY
var flyEyeLocationX
var flyEyeLocationY
@export var speed: float = 60

func _ready() -> void:
	anim.play("flight")



func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null


func _process(delta: float) -> void:
	if player != null:
		playerLocationX = player.global_position.x
		playerLocationY = player.global_position.y
		flyEyeLocationX = flyEye.global_position.x
		flyEyeLocationY = flyEye.global_position.y
		
		if playerLocationX > flyEyeLocationX:
			velocity.x = speed
			anim.flip_h = false
		else:
			velocity.x = -speed
			anim.flip_h = true
			
		if playerLocationY > flyEyeLocationY:
			velocity.y = speed
		else:
			velocity.y = -speed
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
