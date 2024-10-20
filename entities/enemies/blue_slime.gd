extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var hit_area_collision_shape: CollisionShape2D = $hitArea/hitArea_CollisionShape


var player = null
var on_air = false

@export var lives: float = 3
var gettingHit = false 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		anim.play("run")
		velocity += get_gravity() * delta
		if player != null and not on_air:
			if player.global_position.x > global_position.x:
				velocity.x = 200
				if velocity.x > 100:
					velocity.x = 100 
			elif player.global_position.x < global_position.x:
				velocity.x = -200
				if velocity.x < -100:
					velocity.x = -100
		on_air = true
	
	if is_on_floor():
		velocity.x = 0
		anim.play("idle")
		on_air = false
		
	if lives < 1:
		queue_free()
		
	if gettingHit:
		timer.start(1)
		set_modulate(Color(100, 100, 100))
		await get_tree().create_timer(0.1).timeout
		set_modulate(Color(1, 1, 1))
		gettingHit = false

	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
	timer.start(1)


func _on_vision_area_body_exited(body: CharacterBody2D) -> void:
	player = null
	velocity.x = 0
	timer.stop()



func _on_timer_timeout() -> void:
	jump()


func jump():
	if player.global_position.x > global_position.x:
		velocity.y = -350
		anim.flip_h = false
	elif player.global_position.x < global_position.x:
		velocity.y = -350
		anim.flip_h = true


func _on_hit_area_body_entered(body: CharacterBody2D) -> void:
	body.gettingHit = true
	body.lives -= 1
	hit_area_collision_shape.set_disabled(true)
	await get_tree().create_timer(0.5).timeout
	hit_area_collision_shape.set_disabled(false)
