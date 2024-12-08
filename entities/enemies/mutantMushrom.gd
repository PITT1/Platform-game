extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_area_collision: CollisionShape2D = $hitArea/hitArea_collision
@onready var collision_shape_2d: CollisionShape2D = $attackArea/CollisionShape2D

var attack = false
var death = false
var idle = false
var run = false
var takeHit = false

var player: CharacterBody2D = null

@export var speed: float = 100
@export var aceleration : float = 400
@export var lives: float = 5
@export var death_particles: PackedScene
var gettingHit = false

func _ready() -> void:
	on_idle()

func _process(delta: float) -> void:
	if delta:
		pass
	
	if attack:
		anim.play("attack")
	
	if death:
		anim.play("death")
	
	if idle:
		anim.play("idle")
	
	if run:
		anim.play("run")
	
	if takeHit:
		anim.play("takeHit")
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		if not takeHit:
			on_idle()
	
	if player != null and not death and not takeHit and not attack:
		if player.global_position > global_position:
			velocity.x += aceleration * delta
			if velocity.x > speed:
				velocity.x = speed
		elif player.global_position < global_position:
			velocity.x -= aceleration * delta
			if velocity.x < -speed:
				velocity.x = -speed
				
	if velocity.x > 1 and is_on_floor() and not death and not takeHit and not attack:
		on_run()
		anim.flip_h = false
	elif velocity.x < 1 and not death and not takeHit and not attack:
		on_run()
		anim.flip_h = true
	elif velocity.x == 0 and not death and not takeHit and not attack:
		on_idle()
		
	if lives < 1:
		velocity.x = 0
		on_death()
	
	if gettingHit and not death:
		on_takeHit()
	
	if attack and not death:
		velocity.x = 0
		

	move_and_slide()


func on_attack():
	attack = true
	death = false
	idle = false
	run = false
	takeHit = false

func on_death():
	attack = false
	death = true
	idle = false
	run = false
	takeHit = false
	
func on_idle():
	attack = false
	death = false
	idle = true
	run = false
	takeHit = false

func on_run():
	attack = false
	death = false
	idle = false
	run = true
	takeHit = false

func on_takeHit():
	attack = false
	death = false
	idle = false
	run = false
	takeHit = true

func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body


func _on_vision_area_body_exited() -> void:
	player = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "death":
		var instantia = death_particles.instantiate()
		instantia.global_position = global_position
		add_sibling(instantia)
		queue_free()
		
	if anim.get_animation() == "takeHit":
		on_idle()
		collision_shape_2d.set_disabled(true)
		collision_shape_2d.set_disabled(false)
		gettingHit = false
		
	if anim.get_animation() == "attack":
		on_idle()
		collision_shape_2d.set_disabled(true)
		await get_tree().create_timer(0.3).timeout
		collision_shape_2d.set_disabled(false)


func _on_attack_area_body_entered(body: CharacterBody2D) -> void:
	if body.global_position > global_position and not attack:
		anim.flip_h = false
		hit_area_collision.position.x = 28.333
	else:
		hit_area_collision.position.x = -28.333
		anim.flip_h = true
	if not player.death:
		on_attack()


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "attack" and anim.get_frame() == 6:
		hit_area_collision.set_disabled(false)
		await get_tree().create_timer(0.1).timeout
		hit_area_collision.set_disabled(true)
		


func _on_hit_area_body_entered(body: CharacterBody2D) -> void:
	body.gettingHit = true
	body.lives -= 1
	if body.global_position > global_position:
		body.velocity = Vector2(500, -300)
	else:
		body.velocity = Vector2(-500, -300)
