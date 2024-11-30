extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $visionArea
@onready var flee_area: Area2D = $fleeArea

var attack = false
var death = false
var idle = false
var run = false
var takeHit = false

var player = null

var flee = false


var isFallRight = false
var isFallLeft = false 
@export var speed: float = 120
@export var acceleration: float = 300

@export var proyectile: PackedScene
@export var lives: float = 1
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
		
	if flee and not death:
		if player.global_position > global_position and not isFallLeft:
			velocity.x -= acceleration * delta
			if velocity.x < -speed:
				velocity.x = -speed
		elif player.global_position < global_position and not isFallRight:
			velocity.x += acceleration * delta
			if velocity.x > speed:
				velocity.x = speed
	elif not flee and not death:
		if velocity.x > 1:
			velocity.x -= acceleration * delta
			if velocity.x < 1:
				velocity.x = 0
		elif velocity.x < -1:
			velocity.x += acceleration * delta
			if velocity.x > -1:
				velocity.x = 0
				
	if velocity.x > 1 and not attack and not death:
		anim.flip_h = false
		on_run()
	elif velocity.x < -1 and not attack and not death:
		anim.flip_h = true
		on_run()
		
	if isFallLeft or isFallRight:
		flee_area.set_monitoring(false)
	else:
		flee_area.set_monitoring(true)
		
	if lives < 1:
		on_death()
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
	if not flee:
		if player.global_position > global_position:
			anim.flip_h = false
		else:
			anim.flip_h = true
		on_attack()
	

func _on_flee_area_body_entered(body: Node2D) -> void:
	if body:
		flee = true

func _on_flee_area_body_exited(body: Node2D) -> void:
	if body:
		flee = false
		vision_area.set_monitoring(false)
		vision_area.set_monitoring(true)


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "attack" and anim.get_frame() == 6:
		launchingProyectile()
		on_idle()


func launchingProyectile():
	if is_on_floor_only():
		vision_area.scale = Vector2(5, 5)
		var instantiated = proyectile.instantiate()
		add_sibling(instantiated)
		instantiated.global_position = global_position + Vector2(0, -10)
		instantiated.direction = global_position.direction_to(player.global_position)
		await get_tree().create_timer(2).timeout
		vision_area.set_monitoring(false)
		vision_area.scale = Vector2(1, 1)
		vision_area.set_monitoring(true)


func _on_sensor_right_body_exited(body: TileMapLayer) -> void:
	if body.name == "TileMapLayer":
		isFallRight = true 


func _on_sensor_left_body_exited(body: Node2D) -> void:
	if body.name == "TileMapLayer":
		isFallLeft = true 


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "death":
		queue_free()
