extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var opacities = [0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.0]
var reverseOpacities = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
var player: CharacterBody2D = null
var attack = false
var idle = true
var death = false
@onready var vision_area: Area2D = $visionArea
@onready var collision_box: CollisionShape2D = $CollisionShape2D
@onready var vision_box: CollisionShape2D = $visionArea/CollisionShape2D
@onready var hitCollisionShape: CollisionShape2D = $hitArea/CollisionShape2D
@export var lives: float = 5
var gettingHit = false
@export var death_particles: PackedScene
@onready var attack_sound: AudioStreamPlayer2D = $sounds/attack_sound


func _ready() -> void:
	anim.play("idle")
	set_modulate(Color(1, 1, 1, 0.7))
	
func _process(delta: float) -> void:
	if delta:
		pass
	
	if idle:
		anim.play("idle")
		
	if attack:
		anim.play("attack")
	
	if death:
		anim.play("death")
	
	gettingHitAnimation()
	
	if death and anim.get_animation() == "death" and anim.get_frame() == 6:
		await  get_tree().create_timer(0.05).timeout
		deathParticles()
		queue_free()
		
	
	if lives < 1:
		onDeath()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
	if not player.death and not death: 
		attackMode()
	
	

func disappear():
	for i in range(len(opacities)):
		set_modulate(Color(1, 1, 1, opacities[i]))
		await get_tree().create_timer(0.2).timeout
		
func appear():
	if player.global_position > global_position:
		anim.flip_h = false
		collision_box.position.x = -7
	else:
		anim.flip_h = true
		collision_box.position.x = 7
	for i in range(len(reverseOpacities)):
		set_modulate(Color(1, 1, 1, reverseOpacities[i]))
		await get_tree().create_timer(0.2).timeout
		
func aleatoryBool():
	var num = randf()
	if num > 0.5:
		return true
	else:
		return false
	
func onAttack():
	attack = true
	idle = false
	death = false
	
func onIdle():
	attack = false
	idle = true
	death = false

func onDeath():
	attack = false
	idle = false
	death = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "attack":
		onIdle()
		vision_area.set_monitoring(false)
		vision_box.scale.x = 1
		vision_area.set_monitoring(true)	

func attackMode():
	vision_box.scale.x = 8
	disappear()
	await get_tree().create_timer(2).timeout
	if aleatoryBool():
		global_position.x = player.global_position.x - 20
	else:
		global_position.x = player.global_position.x + 40
	appear()
	await get_tree().create_timer(1).timeout
	onAttack()


func _on_vision_area_body_exited(body: Node2D) -> void:
	if body:
		pass


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "attack" and anim.get_frame() == 2:
		activateHitShape()
		hitCollisionShape.position = Vector2(-4, 9.333)
		hitCollisionShape.scale = Vector2(1, 1)
		attack_sound.play()
		
	if anim.get_animation() == "attack" and anim.get_frame() == 5:
		activateHitShape()
		hitCollisionShape.position = Vector2(0, 7.333)
		hitCollisionShape.scale = Vector2(1.5, 1)
		attack_sound.play()
		
	if anim.get_animation() == "attack" and anim.get_frame() == 9:
		activateHitShape()
		hitCollisionShape.position = Vector2(0.667, 2.667)
		hitCollisionShape.scale = Vector2(2, 1.1)
		attack_sound.play()
		
func activateHitShape():
	hitCollisionShape.set_disabled(false)
	await get_tree().create_timer(0.1).timeout
	hitCollisionShape.set_disabled(true)


func _on_hit_area_body_entered(body: Node2D) -> void:
	if not body.death and not body.on_defense:
		body.lives -= 1
		body.gettingHit = true
		body.velocity = global_position.direction_to(body.global_position) * 300
	elif not body.death and body.on_defense:
		body.shield_block = true
		body.velocity = global_position.direction_to(body.global_position) * 200
	else:
		pass
	
func gettingHitAnimation():
	if gettingHit:
		set_modulate(Color(100, 100, 100))
		await get_tree().create_timer(0.1).timeout
		set_modulate(Color(1, 1, 1))
		gettingHit = false


func deathParticles():
	var instantiatedParticles = death_particles.instantiate()
	instantiatedParticles.global_position = global_position
	add_sibling(instantiatedParticles)
