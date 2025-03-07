extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area_collision: CollisionShape2D = $sensors/attack_area/attack_area_collision
@onready var damage_area_collision: CollisionShape2D = $sensors/damage_area/damage_area_collision
@onready var damage_area: Area2D = $sensors/damage_area

var player: Node2D = null
@export var speed: float = 50
@export var aceleration: float = 50
@export var lives: float = 15
@export var attack_particles: PackedScene
var gettingHit = false

@onready var footsteep_sound: AudioStreamPlayer2D = $sounds/footsteep_sound
@onready var roar_sound: AudioStreamPlayer2D = $sounds/roar_sound
@onready var attack_sound: AudioStreamPlayer2D = $sounds/attack_sound

var on_attack = false

enum state {
	attack,
	die,
	idle,
	walk
}

var current_state: state = state.idle

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	match current_state:
		state.attack:
			anim.play("attack")
			velocity.x = 0
			if not on_attack:
				current_state = state.idle
		state.die:
			anim.play("die")
		state.idle:
			anim.play("idle")
			if velocity.x != 0:
				current_state = state.walk
		state.walk:
			anim.play("walk")
			if velocity.x == 0:
				current_state = state.idle
			if on_attack:
				current_state = state.attack
	
	if lives < 1:
		current_state = state.die
	
	
	if player != null:
		if player.global_position.x > global_position.x:
			velocity.x += aceleration * delta
			if velocity.x > speed:
				velocity.x = speed
			if not on_attack:
				anim.flip_h = false
		elif player.global_position.x < global_position.x:
			velocity.x += -aceleration * delta
			if velocity.x < -speed:
				velocity.x = -speed
			if not on_attack:
				anim.flip_h = true
	else:
		velocity.x = 0
	
	if gettingHit == true:
		set_modulate(Color(100, 100, 100))
		await get_tree().create_timer(0.05).timeout
		set_modulate(Color(1, 1, 1))
		gettingHit = false
	
	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
	roar_sound.play()
		


func _on_vision_area_body_exited(body: CharacterBody2D) -> void:
	if body:
		pass
	player = null


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body:
		pass
	on_attack = true
	roar_sound.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "attack":
		on_attack = false
	
	if anim.get_animation() == "die":
		queue_free()


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "walk" and anim.get_frame() == 0:
		footsteep_sound.play()
	
	if anim.get_animation() == "walk" and anim.get_frame() == 5:
		footsteep_sound.play()
	
	if anim.get_animation() == "attack" and anim.get_frame() == 6:
		if anim.flip_h:
			damage_area.set_position(Vector2(-12, 12))
		else:
			damage_area.set_position(Vector2(12, 12))
		
		var intantia = attack_particles.instantiate()
		intantia.position =position - Vector2(0, -80)
		add_sibling(intantia) 
		damage_area_collision.set_disabled(false)
		await get_tree().create_timer(0.2).timeout
		damage_area_collision.set_disabled(true)
		attack_sound.play()


func _on_damage_area_body_entered(body: Node2D) -> void:
	body.gettingHit = true
	body.lives -= 1
	body.velocity.y = -800
