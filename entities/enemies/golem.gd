extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area_collision: CollisionShape2D = $sensors/attack_area/attack_area_collision

var player: Node2D = null
@export var speed: float = 50
@export var aceleration: float = 50
@export var lives: float = 15
var gettingHit = false

var on_attack = false

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
			velocity.x = 0
			if not on_attack:
				current_state = state.idle
		state.die:
			anim.play("die")
		state.hurt:
			anim.play("hurt")
			if not gettingHit:
				current_state = state.idle
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
			if gettingHit == true:
				current_state = state.hurt
	
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
	
	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
		


func _on_vision_area_body_exited(body: CharacterBody2D) -> void:
	if body:
		pass
	player = null


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body:
		pass
	on_attack = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "attack":
		on_attack = false
	
	if anim.get_animation() == "hurt":
		gettingHit = false
	
	if anim.get_animation() == "die":
		queue_free()
