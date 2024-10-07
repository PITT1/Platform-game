extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var vanish_velocity = 0.1


func _ready() -> void:
	anim.play("idle")
	set_modulate(Color(1, 1, 1, 0.7))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()


func _on_vision_area_body_entered(body: Node2D) -> void:
	vanished()
	
func vanished():
	set_modulate(Color(1, 1, 1, 0.7))
