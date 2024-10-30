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
@export var aceleration: float = 400
var gettingHit = false
var death = false
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var platform_collision: CollisionShape2D = $platform/platform_collision
@export var death_particles: PackedScene
@onready var hit_area_collision_shape: CollisionShape2D = $hitArea/hitArea_CollisionShape
@onready var attack_area_collision_shape: CollisionShape2D = $attackArea/attackArea_CollisionShape

var fly = false
var attack = false

var player_on_ceil = false

func _ready() -> void:
	on_fly()


func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass


func _process(delta: float) -> void:
	if attack:
		anim.play("attack")
	
	if fly:
		anim.play("flight")
	
func _physics_process(delta: float) -> void:
	if player != null and not death and not player.death and not player_on_ceil:
		playerLocationX = player.global_position.x
		playerLocationY = player.global_position.y
		flyEyeLocationX = flyEye.global_position.x
		flyEyeLocationY = flyEye.global_position.y
		
		if playerLocationX > flyEyeLocationX:
			velocity.x += aceleration * delta
			anim.flip_h = false
			collision_shape.set_position(Vector2(5.5, 1.5))
			platform_collision.set_position(Vector2(5.5, -3.5))
			attack_area_collision_shape.set_position(Vector2(5, 2))
			if velocity.x > speed:
				velocity.x = speed
		else:
			velocity.x -= aceleration * delta
			anim.flip_h = true
			collision_shape.set_position(Vector2(-5.5, 1.5))
			platform_collision.set_position(Vector2(-5.5, -3.5))
			attack_area_collision_shape.set_position(Vector2(-5, 2))
			if velocity.x < -speed:
				velocity.x = -speed
			
		if playerLocationY > flyEyeLocationY:
			velocity.y += aceleration * delta
			if velocity.y > speed:
				velocity.y = speed
		else:
			velocity.y -= aceleration * delta
			if velocity.y < -speed:
				velocity.y = -speed
			
		if lives < 1:
			death = true
			var instantiated_particles = death_particles.instantiate()
			add_sibling(instantiated_particles)
			instantiated_particles.global_position = global_position
			flyEye.queue_free()
			
	else:
		if player_on_ceil:
			velocity.x = 0
			velocity.y = 60
		else:
			velocity.x = 0
			velocity.y = 0
	move_and_slide()



func _on_attack_area_body_entered(body: CharacterBody2D) -> void:
	if not death:
		on_attack()
		player_on_ceil = true
		await get_tree().create_timer(0.6).timeout
		on_fly()
	

func _on_attack_area_body_exited(body: CharacterBody2D) -> void:
	player_on_ceil = false



func on_attack():
	attack = true
	fly = false

func on_fly():
	attack = false
	fly = true


func _on_hit_area_body_entered(body: CharacterBody2D) -> void:
	body.lives -= 1
	body.gettingHit = true
	if body.global_position > global_position:
		body.velocity = Vector2(300, -300)
	else:
		body.velocity = Vector2(-300, -300)


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "attack" and anim.get_frame() == 6:
		hit_area_collision_shape.set_disabled(false)
		if anim.is_flipped_h():
			hit_area_collision_shape.set_position(Vector2(-5, 2))
		else:
			hit_area_collision_shape.set_position(Vector2(5, 2))
		await get_tree().create_timer(0.1).timeout
		hit_area_collision_shape.set_disabled(true)
