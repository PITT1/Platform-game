extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackSprite: Sprite2D = $"attack sprite"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var player: CharacterBody2D = null
@onready var mushroom: CharacterBody2D = $"."
@export var speed: float = 100
@export var aceleration: float = 5
var onAttack = false
@onready var hitArea: CollisionShape2D = $hitArea/CollisionShape2D



func _ready() -> void:
	attackSprite.visible = false
	anim.play("idle")

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if player != null:
		if mushroom.global_position.x < player.global_position.x:
			if velocity.x < speed:
				velocity.x += aceleration
			elif velocity.x == speed:
				velocity.x = speed
		else:
			if velocity.x > -speed:
				velocity.x -= aceleration
			elif velocity.x == -speed:
				velocity.x = -speed
	else:
		velocity.x = 0
	animations()

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null

func animations():
	if velocity.x == 0 and not onAttack:
		anim.play("idle")
	else:
		anim.play("run")
		
	if  velocity.x > 0:
		anim.flip_h = false
	elif velocity.x < 0:
		anim.flip_h = true


func _on_attack_area_body_entered(body: Node2D) -> void:
	onAttack = true
	anim.visible = false
	if player.global_position.x > mushroom.global_position.x:
		hitArea.position.x = 24
		animation_player.play("attack")
	else:
		hitArea.position.x = -24
		animation_player.play("attackLeft")

func _on_attack_area_body_exited(body: Node2D) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	onAttack = false
	anim.visible = true
