extends Node2D
@onready var collision_area: Area2D = $collisionArea
@onready var anim: AnimationPlayer = $AnimationPlayer

var direction = Vector2(0, 0)
@export var velocity: float = 200


func _ready() -> void:
	if direction.x > 0:
		anim.play("rotate_Right")
	else:
		anim.play("rotate_Left")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * delta * velocity


func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D" and not body.on_defense:
		body.lives -= 1
		body.gettingHit = true
		body.velocity = global_position.direction_to(body.global_position) * 200
	elif body.name == "CharacterBody2D" and body.on_defense:
		body.shield_block = true
		body.velocity = global_position.direction_to(body.global_position) * 100
	else:
		pass
		
	
	queue_free()
	direction = Vector2(0, 0)
