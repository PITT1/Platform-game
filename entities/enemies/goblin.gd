extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var attack = false
var death = false
var idle = false
var run = false
var takeHit = false


func _ready() -> void:
	on_idle()

func _process(delta: float) -> void:
	
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
	pass