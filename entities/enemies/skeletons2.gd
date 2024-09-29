extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var player: CharacterBody2D = null
@onready var skeleton: CharacterBody2D = $"."
@export var speed: float = 40
@export var aceleration: float = 2
@export var lives: int = 5
var gettingHit = false
@onready var spriteAttack: Sprite2D = $Sprite2D
@onready var hitAreaCollision: CollisionShape2D = $hitArea/CollisionShape2D

func _ready() -> void:
	anim.play("idle")
	spriteAttack.visible = false
	hitAreaCollision.disabled = true

func _process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		
	movement()
	animations()	
	
	

	move_and_slide()


func _on_vision_area_body_entered(body: Node2D) -> void:
	player = body


func _on_vision_area_body_exited(body: Node2D) -> void:
	player = null
	
func movement():
	if player and not animationPlayer.current_animation == "attackRight" and not animationPlayer.current_animation == "attackLeft":
		if player.global_position.x > skeleton.global_position.x:
			velocity.x += aceleration
			if velocity.x > speed:
				velocity.x = speed
		
		else:
			velocity.x -= aceleration
			if velocity.x < -speed:
				velocity.x = -speed
				
func animations():
	if velocity.x > 0:
		anim.play("walk")
		anim.flip_h = false
	elif velocity.x == 0:
		anim.play("idle")
	elif velocity.x < 0:
		anim.play("walk")
		anim.flip_h = true


func _on_attack_area_body_entered(body: Node2D) -> void:
	if player.global_position.x > skeleton.global_position.x and not animationPlayer.current_animation == "attackLeft":
		velocity.x = 0
		anim.visible = false
		anim.flip_h = false
		animationPlayer.play("attackRight")
		await get_tree().create_timer(0.78).timeout
		anim.visible = true
	elif player.global_position.x < skeleton.global_position.x and not animationPlayer.current_animation == "attackRight":
		velocity.x = 0
		anim.visible = false
		anim.flip_h = true
		animationPlayer.play("attackLeft")
		await get_tree().create_timer(0.80).timeout
		anim.visible = true


func _on_hit_area_body_entered(body: Node2D) -> void:
	body.lives -= 1
	if player.global_position.x > skeleton.global_position.x:
		body.velocity = Vector2(400, -200)
	else:
		body.velocity = Vector2(-400, -200)
