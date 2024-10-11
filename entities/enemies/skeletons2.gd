extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $visionArea
@onready var hit_area_collision_shape: CollisionShape2D = $hitArea/hitArea_collisionShape
@onready var attack_area: Area2D = $attackArea

var attack = false
var death = false
var idle = false
var shield = false
var takeHit = false
var walk = false

@export var lives: int = 5
@export var speed: float = 50
@export var acceleration = 80
var gettingHit = false
var player: CharacterBody2D

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
		
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity = get_gravity() * delta
		
	if player != null and attack == false:
		on_walk()
		if player.global_position.x > global_position.x:
			anim.flip_h = false
			velocity.x += acceleration * delta
			if velocity.x > speed:
				velocity.x = speed
				
		if player.global_position.x < global_position.x:
			anim.flip_h = true
			velocity.x -= acceleration * delta
			if velocity.x < -speed:
				velocity.x = -speed
	
	move_and_slide()


func on_attack():
	attack = true
	death = false
	idle = false
	shield = false
	takeHit = false
	walk = false
	
func on_death():
	attack = false
	death = true
	idle = false
	shield = false
	takeHit = false
	walk = false
	
func on_idle():
	attack = false
	death = false
	idle = true
	shield = false
	takeHit = false
	walk = false
	
func on_shield():
	attack = false
	death = false
	idle = false
	shield = true
	takeHit = false
	walk = false
	
func on_takeHit():
	attack = false
	death = false
	idle = false
	shield = false
	takeHit = true
	walk = false
	
func on_walk():
	attack = false
	death = false
	idle = false
	shield = false
	takeHit = false
	walk = true


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
	await get_tree().create_timer(0.5).timeout


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "attack":
		attack = false
		attack_area.set_monitoring(false)
		vision_area.set_monitoring(false)
		attack_area.set_monitoring(true)
		vision_area.set_monitoring(true)
