extends CharacterBody2D

var player : CharacterBody2D = null
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var roar_sound: AudioStreamPlayer2D = $roar_sound
@onready var flying_sound: AudioStreamPlayer2D = $flying_sound

@export var speed: float = 60
@export var acceleration: float = 300
@export var lives: float = 5
@export var death_particles: PackedScene
@export var proyectile: PackedScene
@export var proyectile_velocity = 200
var gettingHit = false

var on_margin_area = false

func _ready() -> void:
	anim.play("fly")

func _physics_process(delta: float) -> void:
	
	if player and not on_margin_area:
		movement_to_player(delta)
	elif player and on_margin_area:
		run_away_to_player(delta)
	
	if player:
		if player.global_position.x > global_position.x:
			anim.flip_h = false
			collision.set_position(Vector2(6, 2))
		else:
			anim.flip_h = true
			collision.set_position(Vector2(-6, 2))
	
	
	move_and_slide()
	
	if lives < 1:
		var instantiated_particles = death_particles.instantiate()
		add_sibling(instantiated_particles)
		instantiated_particles.global_position = global_position
		queue_free()
	
	
func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	if body:
		player = body
		roar_sound.play()
		timer.start()

func _on_vision_area_body_exited(body: CharacterBody2D) -> void:
	if body:
		player = null
		timer.stop()

func _on_margin_area_body_entered(body: CharacterBody2D) -> void:
	on_margin_area = true
	roar_sound.play()
	if body:
		pass

func _on_margin_area_body_exited(body: Node2D) -> void:
	on_margin_area = false
	if body:
		pass

func _on_timer_timeout() -> void:
	roar_sound.play()
	shot_to_player()


func movement_to_player(delta):
	if player.global_position.x > global_position.x:
		velocity += Vector2.RIGHT * acceleration * delta
		if velocity.x > speed:
			velocity.x = speed
				
	if player.global_position.x < global_position.x:
		velocity += Vector2.LEFT * acceleration * delta
		if velocity.x < -speed:
			velocity.x = -speed 
		
	if player.global_position.y > global_position.y:
		velocity += Vector2.DOWN * acceleration * delta
		if velocity.y > speed:
			velocity.y = speed
		
	if player.global_position.y < global_position.y:
		velocity += Vector2.UP * acceleration * delta
		if velocity.y < -speed:
			velocity.y = -speed

func run_away_to_player(delta):
	if player.global_position.x < global_position.x:
		velocity += Vector2.RIGHT * acceleration * delta
		if velocity.x < -speed:
			velocity.x = -speed
				
	if player.global_position.x > global_position.x:
		velocity += Vector2.LEFT * acceleration * delta
		if velocity.x > speed:
			velocity.x = speed 
		
	if player.global_position.y < global_position.y:
		velocity += Vector2.DOWN * acceleration * delta
		if velocity.y < -speed:
			velocity.y = -speed
		
	if player.global_position.y > global_position.y:
		velocity += Vector2.UP * acceleration * delta
		if velocity.y > speed:
			velocity.y = speed

func shot_to_player():
	var dir_to_player: Vector2 
	var proyectile_instantia = proyectile.instantiate()
	add_sibling(proyectile_instantia)
	if player:
		dir_to_player = global_position.direction_to(player.global_position)
		proyectile_instantia.position = global_position
		proyectile_instantia.velocity = dir_to_player * proyectile_velocity


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "fly" and anim.get_frame() == 6:
		flying_sound.play()
