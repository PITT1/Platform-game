extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $visionArea
@onready var hit_area_collision_shape: CollisionShape2D = $hitArea/hitArea_collisionShape
@onready var attack_area: Area2D = $attackArea
@onready var character_collision: CollisionShape2D = $character_collision

var attack = false
var death = false
var idle = false
var shield = false
var takeHit = false
var walk = false
var contra_attack = false

@export var lives: float = 5
@export var lives_limit: float = 5 
@export var speed: float = 50
@export var acceleration = 120
@export_range(0.0, 1.0, 0.01) var attack_block_probability: float = 0.60
var gettingHit = false
var player: CharacterBody2D
var proces_attack = false

func _ready() -> void:
	on_idle()
	


func _process(delta: float) -> void:
	if attack:
		anim.play("attack")
		
	if death:
		anim.play("death")
		
	if idle:
		anim.play("idle")
		
	if shield:
		anim.play("shield")
		
	if takeHit:
		anim.play("takeHit")
		
	if walk:
		anim.play("walk")
	
	if contra_attack:
		anim.play("contra_attack")
		
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if player != null and not attack and not gettingHit and not death and not contra_attack:
		on_walk()
		if player.global_position.x > global_position.x:
			anim.flip_h = false
			character_collision.position = Vector2(2, 4)
			velocity.x += acceleration * delta
			if velocity.x > speed:
				velocity.x = speed
				
		if player.global_position.x < global_position.x:
			anim.flip_h = true
			character_collision.position = Vector2(-2, 4)
			velocity.x -= acceleration * delta
			if velocity.x < -speed:
				velocity.x = -speed
				
	if attack and not gettingHit and not death and not contra_attack:
		vision_area.scale = Vector2(5, 5)
	else:
		vision_area.scale = Vector2(1, 1)
		
	if gettingHit and not death:
		velocity.x = 0
		if attack_block() == 1:
			on_contra_attack()
			if lives < lives_limit:
				lives += 1
		elif attack_block() == 2:
			on_takeHit()
		
	if lives < 1:
		on_death()
	
	
	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body


func _on_vision_area_body_exited(body: Node2D) -> void:
	player = null


func _on_attack_area_body_entered(body: CharacterBody2D) -> void:
	if player:
		if player.global_position.x > global_position.x:
			anim.flip_h = false 
		else:
			anim.flip_h = true
	velocity.x = 0
	on_attack()

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "attack":
		attack = false
		attack_area.set_monitoring(false)
		vision_area.set_monitoring(false)
		attack_area.set_monitoring(true)
		vision_area.set_monitoring(true)
		
	if anim.get_animation() == "takeHit":
		gettingHit = false
		attack_area.set_monitoring(false)
		vision_area.set_monitoring(false)
		attack_area.set_monitoring(true)
		vision_area.set_monitoring(true)
		
	if anim.get_animation() == "death":
		queue_free()
	
	if anim.get_animation() == "contra_attack":
		on_idle()
		gettingHit = false
		attack_area.set_monitoring(false)
		vision_area.set_monitoring(false)
		attack_area.set_monitoring(true)
		vision_area.set_monitoring(true)


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "attack" and anim.get_frame() == 6:
		if anim.flip_h == false:
			hit_area_collision_shape.position = Vector2(35.833, -4.167)
			hit_area_collision_shape.set_disabled(false)
		else:
			hit_area_collision_shape.position = Vector2(-35.833, -4.167)
			hit_area_collision_shape.set_disabled(false)
		await get_tree().create_timer(0.2).timeout
		hit_area_collision_shape.set_disabled(true)


func _on_hit_area_body_entered(body: CharacterBody2D) -> void:
	body.lives -= 1
	body.gettingHit = true
	if body.global_position > global_position:
		body.velocity = Vector2(400, -300)
	else:
		body.velocity = Vector2(-400, -300)

func attack_block():
	if not proces_attack:
		var num = randf()
		print(num)
		proces_attack = true
		if num < attack_block_probability:
			return 1
		elif num > attack_block_probability:
			return 2

func on_attack():
	attack = true
	death = false
	idle = false
	shield = false
	takeHit = false
	walk = false
	contra_attack = false
	
func on_death():
	attack = false
	death = true
	idle = false
	shield = false
	takeHit = false
	walk = false
	contra_attack = false
	
func on_idle():
	attack = false
	death = false
	idle = true
	shield = false
	takeHit = false
	walk = false
	contra_attack = false
	
func on_shield():
	attack = false
	death = false
	idle = false
	shield = true
	takeHit = false
	walk = false
	contra_attack = false
	
func on_takeHit():
	attack = false
	death = false
	idle = false
	shield = false
	takeHit = true
	walk = false
	contra_attack = false
	
func on_walk():
	attack = false
	death = false
	idle = false
	shield = false
	takeHit = false
	walk = true
	contra_attack = false

func on_contra_attack():
	attack = false
	death = false
	idle = false
	shield = false
	takeHit = false
	walk = false
	contra_attack = true
