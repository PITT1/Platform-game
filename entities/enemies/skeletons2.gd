extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $visionArea
@onready var hit_area_collision_shape: CollisionShape2D = $hitArea/hitArea_collisionShape
@onready var attack_area: Area2D = $attackArea
@onready var character_collision: CollisionShape2D = $character_collision
@onready var walk_sound: AudioStreamPlayer2D = $sounds/walk_sound
@onready var sombie_sound: AudioStreamPlayer2D = $sounds/sombie_sound
@onready var attack_sound: AudioStreamPlayer2D = $sounds/attack_sound

var attack = false
var death = false
var idle = false
var shield = false
var walk = false

@export var lives: float = 5
@export var lives_limit: float = 5 
@export var speed: float = 50
@export var acceleration = 120
var gettingHit = false
var player: CharacterBody2D

enum state {
	attack,
	contraAttack,
	death,
	idle,
	shield,
	takeHit,
	walk
}

var current_state: state = state.idle

func _ready() -> void:
	on_idle()
	print(current_state)
	


func _process(delta: float) -> void:
	if delta:
		pass
	
	if attack:
		anim.play("attack")
		
	if death:
		anim.play("death")
		
	if idle:
		anim.play("idle")
		
	if shield:
		anim.play("shield")
		
	if walk:
		anim.play("walk")
		
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if player != null and not attack and not gettingHit and not death:
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
				
	if attack and not gettingHit and not death:
		vision_area.scale = Vector2(5, 5)
	else:
		vision_area.scale = Vector2(1, 1)
		
	if gettingHit and not death:
		velocity.x = 0
		set_modulate(Color(100, 100, 100))
		await get_tree().create_timer(0.1).timeout
		set_modulate(Color(1, 1, 1))
		gettingHit = false
		
	if lives < 1:
		on_death()
	
	
	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	if body:
		player = body
		sombie_sound.play()


func _on_vision_area_body_exited(body: Node2D) -> void:
	if body:
		player = null
		if not sombie_sound.is_playing():
			sombie_sound.play()


func _on_attack_area_body_entered(body: CharacterBody2D) -> void:
	if player:
		if player.global_position.x > global_position.x:
			anim.flip_h = false 
		else:
			anim.flip_h = true
	velocity.x = 0
	on_attack()
	if not sombie_sound.is_playing():
		sombie_sound.play()
	if body:
		pass

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
		attack_sound.play()
		if anim.flip_h == false:
			hit_area_collision_shape.position = Vector2(35.833, -4.167)
			hit_area_collision_shape.set_disabled(false)
		else:
			hit_area_collision_shape.position = Vector2(-35.833, -4.167)
			hit_area_collision_shape.set_disabled(false)
		await get_tree().create_timer(0.2).timeout
		hit_area_collision_shape.set_disabled(true)
	
	if anim.get_animation() == "walk" and anim.get_frame() == 0:
		walk_sound.play()
	
	if anim.get_animation() == "walk" and anim.get_frame() == 2:
		walk_sound.play()


func _on_hit_area_body_entered(body: CharacterBody2D) -> void:
	if not body.death and not body.on_defense:
		body.lives -= 1
		body.gettingHit = true
		if body.global_position > global_position:
			body.velocity = Vector2(400, -300)
		else:
			body.velocity = Vector2(-400, -300)
	elif not body.death and body.on_defense:
		body.shield_block = true
		if body.global_position > global_position:
			body.velocity = Vector2(200, -150)
		else:
			body.velocity = Vector2(-200, -150)
	else:
		pass

func on_attack():
	attack = true
	death = false
	idle = false
	shield = false
	walk = false
	
func on_death():
	attack = false
	death = true
	idle = false
	shield = false
	walk = false
	
func on_idle():
	attack = false
	death = false
	idle = true
	shield = false
	walk = false
	
func on_shield():
	attack = false
	death = false
	idle = false
	shield = true
	walk = false
	
func on_walk():
	attack = false
	death = false
	idle = false
	shield = false
	walk = true
