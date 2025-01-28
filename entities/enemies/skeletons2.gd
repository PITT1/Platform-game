extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $visionArea
@onready var hit_area_collision_shape: CollisionShape2D = $hitArea/hitArea_collisionShape
@onready var attack_area: Area2D = $attackArea
@onready var character_collision: CollisionShape2D = $character_collision
@onready var walk_sound: AudioStreamPlayer2D = $sounds/walk_sound
@onready var sombie_sound: AudioStreamPlayer2D = $sounds/sombie_sound
@onready var attack_sound: AudioStreamPlayer2D = $sounds/attack_sound
@onready var collision_shape_2d: CollisionShape2D = $attackArea/CollisionShape2D

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
	walk,
	wait
}

var current_state: state = state.idle
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	match current_state:
		state.attack:
			anim.play("attack")
		state.contraAttack:
			pass
		state.death:
			anim.play("death")
		state.idle:
			anim.play("idle")
		state.shield:
			pass
		state.takeHit:
			pass
		state.walk:
			anim.play("walk")
			move_to_player(delta)
		state.wait:
			anim.play("idle")
		
	if gettingHit:
		velocity.x = 0
		set_modulate(Color(100, 100, 100))
		await get_tree().create_timer(0.1).timeout
		set_modulate(Color(1, 1, 1))
		gettingHit = false
		
	if lives < 1:
		current_state = state.death
	
	
	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	if body:
		player = body
		current_state = state.walk
		sombie_sound.play()


func _on_vision_area_body_exited(body: Node2D) -> void:
	if body:
		current_state = state.idle
		player = null
		if not sombie_sound.is_playing():
			sombie_sound.play()


func _on_attack_area_body_entered(body: CharacterBody2D) -> void:
	if player:
		current_state = state.attack
		if player.global_position.x > global_position.x:
			anim.flip_h = false 
		else:
			anim.flip_h = true
	velocity.x = 0
	if not sombie_sound.is_playing():
		sombie_sound.play()
	if body:
		pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "attack":
		current_state = state.walk
		collision_shape_2d.set_disabled(true)
		await get_tree().create_timer(1).timeout
		collision_shape_2d.set_disabled(false)
		
	if anim.get_animation() == "takeHit":
		gettingHit = false
		
	if anim.get_animation() == "death":
		queue_free()


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

func move_to_player(delta):
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
