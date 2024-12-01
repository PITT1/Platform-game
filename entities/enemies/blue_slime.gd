extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_area_collision_shape: CollisionShape2D = $hitArea/hitArea_CollisionShape


@export var lives: float = 3
@export var move_to_the_right = true
@export var aceleration: float = 300
@export var speed: float = 60
@export var death_particles: PackedScene
var gettingHit = false 
@onready var run_sound: AudioStreamPlayer2D = $run_sound

func _ready() -> void:
	anim.play("idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if velocity.x > 10 or velocity.x < -10:
		anim.play("run")
	else:
		anim.play("idle")
	
	if velocity.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true
	
	if is_on_wall():
		move_to_the_right = !move_to_the_right
	
	if is_on_floor() and move_to_the_right:
		velocity += Vector2.RIGHT * aceleration * delta
		if velocity.x > speed:
			velocity.x = speed
	elif is_on_floor() and not move_to_the_right:
		velocity += Vector2.LEFT * aceleration * delta
		if velocity.x < -speed:
			velocity.x = -speed
	
	if lives < 1:
		queue_free()
		var instatiated_particles = death_particles.instantiate()
		add_sibling(instatiated_particles)
		instatiated_particles.global_position = global_position
	move_and_slide()


func _on_hit_area_body_entered(body: CharacterBody2D) -> void:
	if not body.death:
		body.lives -= 1
		body.gettingHit = true
		body.velocity = global_position.direction_to(body.global_position) * 500


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "run" and anim.get_frame() == 5:
		run_sound.play()
