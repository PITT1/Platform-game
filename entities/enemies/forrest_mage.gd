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

var player: CharacterBody2D

func _ready() -> void:
	on_idle()
	

func _process(delta: float) -> void:
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


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()
	
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


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
	vision_area.scale = Vector2(5, 5)
	if player.global_position > global_position:
		anim.flip_h = false
	else:
		anim.flip_h = true
	on_spell()
	await get_tree().create_timer(1).timeout
	on_teleport_out()


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "teleport_out":
		visible = false
	
	if aleatoryBool():
		global_position.x = player.global_position.x + 20
	else:
		global_position.x = player.global_position.x - 20
	
	visible = true
	on_teleport_in()
