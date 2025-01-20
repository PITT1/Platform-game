extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var player : CharacterBody2D = null
@export var speed: float = 60
@export var acceleration: float = 300
@export var lives: float = 3
@export var death_particles: PackedScene
var gettingHit = false
@onready var hit_box: CollisionShape2D = $CollisionShape2D
@onready var hit_area_collision: CollisionShape2D = $hitArea/hitArea_collision
@onready var flying_sound: AudioStreamPlayer2D = $sound/flying_sound
@onready var roar_sound: AudioStreamPlayer2D = $sound/roar_sound

func _ready() -> void:
	anim.play("fly")

func _physics_process(delta: float) -> void:
	if player != null and not player.death and not gettingHit:
		movement(delta)
	if player:
		if player.death:
			velocity = Vector2.ZERO
		
	if lives < 1:
		queue_free()
		if death_particles:
			var instantiated_particles = death_particles.instantiate()
			add_sibling(instantiated_particles)
			instantiated_particles.global_position = global_position
		
	if gettingHit:
		anim.play("gettingHit")
		
	if player:
		if player.global_position.x > global_position.x:
			anim.flip_h = false
			hit_box.set_position(Vector2(6, 3))
			hit_area_collision.set_position(Vector2(6, 3))
		else:
			anim.flip_h = true
			hit_box.set_position(Vector2(-6, 3))
			hit_area_collision.set_position(Vector2(-6, 3))
		
	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
	roar_sound.play()

func movement(delta):
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


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "gettingHit":
		gettingHit = false
		anim.play("fly")


func _on_hit_area_body_entered(body: Node2D) -> void:
	if not body.death and not body.on_defense:
		body.gettingHit = true
		roar_sound.play()
		body.lives -= 1
		velocity = body.global_position.direction_to(global_position) * 200
	elif not body.death and body.on_defense:
		velocity = body.global_position.direction_to(global_position) * 200
		body.velocity = global_position.direction_to(body.global_position) * 200
		body.velocity.y = -200


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "fly" and anim.get_frame() == 7:
		flying_sound.play()
