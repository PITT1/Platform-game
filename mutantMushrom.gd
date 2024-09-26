extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackSprite: Sprite2D = $"attack sprite"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	attackSprite.visible = false
	anim.play("idle")
	animation_player.play("attack")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()
