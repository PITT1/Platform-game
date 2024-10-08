extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var opacities = [0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.0]
var reverseOpacities = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
var player: CharacterBody2D = null

func _ready() -> void:
	anim.play("idle")
	set_modulate(Color(1, 1, 1, 0.7))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()


func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body
	disappear()
	await get_tree().create_timer(2).timeout
	global_position.x = player.global_position.x - 10
	appear()
	
	

func disappear():
	for i in range(len(opacities)):
		set_modulate(Color(1, 1, 1, opacities[i]))
		await get_tree().create_timer(0.2).timeout
		
func appear():
	for i in range(len(reverseOpacities)):
		set_modulate(Color(1, 1, 1, reverseOpacities[i]))
		await get_tree().create_timer(0.2).timeout
	
