extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $visionArea
@onready var hit_collision_shape: CollisionShape2D = $hitArea/CollisionShape2D
@onready var forrest_mage_colission_shape: CollisionShape2D = $CollisionShape2D

var death = false
var idle = true
var spell = false
var teleport_in = false
var teleport_out = false
var thorns = false
var attack_type = 0
@export var lives : float = 5
var gettingHit = false

var player: CharacterBody2D
@export var proyectil: PackedScene
@export var death_particles: PackedScene

func _ready() -> void:
	on_idle()
	hit_collision_shape.set_disabled(true)
	

func _process(delta: float) -> void:
	if delta:
		pass
	if idle:
		anim.play("idle")
		
	if death:
		anim.play("death")
		
	if spell:
		anim.play("spell")
		
	if teleport_in:
		anim.play("teleport_in")
		
	if teleport_out:
		anim.play("teleport_out")
		
	if thorns:
		anim.play("thorns")
		
	if gettingHit:
		gettingHitAnimation()
		
	if lives < 1:
		on_death()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if velocity.x > 1:
		velocity.x -= 100 * delta
	elif velocity.x < -1:
		velocity.x += 100 * delta
	move_and_slide()
	


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
	if aleatoryBool():
		attack_type = 1
	else:
		attack_type = 0
	vision_area.scale = Vector2(5, 5)
	on_seePlayer()
	on_idle()
	await get_tree().create_timer(0.5).timeout
	on_teleport_out()


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "teleport_out" and attack_type == 0 and not death and not player.death:
		set_modulate(Color(1, 1, 1, 0))
		if aleatoryBool():
			global_position.x = player.global_position.x + 40
		else:
			global_position.x = player.global_position.x - 40
	elif anim.get_animation() == "teleport_out" and attack_type == 1 and not death and not player.death:
		set_modulate(Color(1, 1, 1, 0))
		if aleatoryBool():
			global_position.x = player.global_position.x + 80
		else:
			global_position.x = player.global_position.x - 80
	on_teleport_in()
	set_modulate(Color(1, 1, 1, 1))
	on_seePlayer()
	
	if anim.get_animation() == "teleport_in" and attack_type == 0 and not death:
		on_idle()
		await get_tree().create_timer(0.1).timeout
		on_thorns()
	elif anim.get_animation() == "teleport_in" and attack_type == 1 and not death:
		on_idle()
		await get_tree().create_timer(0.1).timeout
		on_spell()
		
	if anim.get_animation() == "thorns":
		on_idle()
		
	
		
func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "thorns" and anim.get_frame() == 4 and not death:
		hit_collision_shape.set_disabled(false)
		await get_tree().create_timer(0.2).timeout
		hit_collision_shape.set_disabled(true)
		await get_tree().create_timer(0.5).timeout
		vision_area.set_monitoring(false)
		vision_area.set_monitoring(true)
		
	if anim.get_animation() == "spell" and anim.get_frame() == 5 and not death:
		on_idle()
		var instant_proyectil = proyectil.instantiate()
		instant_proyectil.global_position = global_position + Vector2(0, -20)
		add_sibling(instant_proyectil)
		var direction_to_player = global_position.direction_to(player.global_position)
		instant_proyectil.velocity = direction_to_player * 250
		await get_tree().create_timer(1).timeout
		vision_area.set_monitoring(false)
		vision_area.set_monitoring(true)
		
	if anim.get_animation() == "death" and anim.get_frame() == 5:
		queue_free()
		var instantParticles = death_particles.instantiate()
		instantParticles.global_position = global_position
		add_sibling(instantParticles)

func on_idle():
	death = false
	idle = true
	spell = false
	teleport_in = false
	teleport_out = false
	thorns = false
	
func on_death():
	death = true
	idle = false
	spell = false
	teleport_in = false
	teleport_out = false
	thorns = false

func on_spell():
	death = false
	idle = false
	spell = true
	teleport_in = false
	teleport_out = false
	thorns = false
	
func on_teleport_in():
	death = false
	idle = false
	spell = false
	teleport_in = true
	teleport_out = false
	thorns = false

func on_teleport_out():
	death = false
	idle = false
	spell = false
	teleport_in = false
	teleport_out = true
	thorns = false
	
func on_thorns():
	death = false
	idle = false
	spell = false
	teleport_in = false
	teleport_out = false
	thorns = true
	
func aleatoryBool():
	var num = randf()
	if num > 0.5:
		return true
	else:
		return false
		
func on_seePlayer():
	if player.global_position > global_position:
		anim.flip_h = false
	else:
		anim.flip_h = true


func _on_hit_area_body_entered(body: CharacterBody2D) -> void:
	body.lives -= 1
	body.velocity.y = -200
	body.gettingHit = true

func gettingHitAnimation():
	set_modulate(Color(100, 100, 100))
	await get_tree().create_timer(0.1).timeout
	set_modulate(Color(1, 1, 1))
	gettingHit = false
