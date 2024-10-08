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

func _ready() -> void:
	anim.play("idle")
	set_modulate(Color(1, 1, 1, 0.7))
	
func _process(delta: float) -> void:
	if idle:
		anim.play("idle")
		
	if attack:
		anim.play("attack")
	
	if death:
		anim.play("death")


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
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
		await get_tree().create_timer(0.1).timeout
		vision_area.set_monitoring(true)

func attackMode():
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
	pass
