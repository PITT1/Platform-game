extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var player: Node2D = null

enum state {
	attack,
	die,
	hurt,
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
		state.die:
			anim.play("die")
		state.hurt:
			anim.play("hurt")
		state.idle:
			anim.play("idle")
			if velocity.x != 0:
				current_state = state.walk
		state.walk:
			anim.play("walk")
			if velocity.x == 0:
				current_state = state.idle
	
	
	if player != null:
		if player.global_position.x > global_position.x:
			velocity.x = 50
			anim.flip_h = false
		elif player.global_position.x < global_position.x:
			velocity.x = -50
			anim.flip_h = true
	else:
		velocity.x = 0
	
	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
		


func _on_vision_area_body_exited(body: CharacterBody2D) -> void:
	if body:
		pass
	player = null
