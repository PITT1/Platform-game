extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackSprite: Sprite2D = $"attack sprite"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var player: CharacterBody2D = null
@onready var mushroom: CharacterBody2D = $"."
@export var speed: float = 100
@export var aceleration: float = 5
var onAttack = false
@export var lives = 5
var gettingHit = false
var death = false
@onready var hitArea: CollisionShape2D = $hitArea/CollisionShape2D
@onready var attack_area: Area2D = $attackArea



func _ready() -> void:
	attackSprite.visible = false
	anim.play("idle")
	hitArea.disabled = true

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if player != null and not death:
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
	gettingHitAnimation()
	
	if lives < 1:
		death = true
		

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null

func animations():
	if velocity.x == 0 and not onAttack and not death:
		anim.play("idle")
	elif velocity.x and not onAttack and  not death:
		anim.play("run")
	elif death:
		attack_area.monitoring = false
		anim.play("death")
		
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
	if anim_name == "attack" or anim_name == "attackLeft":
		onAttack = false
		anim.visible = true


func _on_hit_area_body_entered(body: Node2D) -> void:
	if body.lives != 0:
		body.lives -= 1
		body.gettingHit = true
		if anim.flip_h == false:
			body.velocity = Vector2(400, -400)
		else:
			body.velocity = Vector2(-400, -400)


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "death":
		mushroom.queue_free()
		

func gettingHitAnimation():
	if gettingHit:
		set_modulate(Color(100, 100, 100))
		await get_tree().create_timer(0.1).timeout
		set_modulate(Color(1, 1, 1))
		gettingHit = false
