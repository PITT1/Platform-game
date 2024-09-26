extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackSprite: Sprite2D = $"attack sprite"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var player: CharacterBody2D = null
@onready var mushroom: CharacterBody2D = $"."
@export var speed: float = 100



func _ready() -> void:
	attackSprite.visible = false
	anim.play("idle")

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if player != null:
		if mushroom.global_position.x < player.global_position.x:
			velocity.x = speed
		else:
			velocity.x = -speed
	animations()

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null

func animations():
	if velocity.x == 0:
		anim.play("idle")
	else:
		anim.play("run")
		
	if  velocity.x > 0:
		anim.flip_h = false
	elif velocity.x < 0:
		anim.flip_h = true
