extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_sensor: CollisionShape2D = $sensor/Collision_sensor
@onready var collision_hit_area: CollisionShape2D = $hit_area/Collision_hit_area


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")


func _on_sensor_body_entered(body: CharacterBody2D) -> void:
	if body:
		await get_tree().create_timer(0.5).timeout
		anim.play("attack")
		await get_tree().create_timer(0.2).timeout
		anim.play("retract")
		collision_sensor.set_disabled(true)
		await get_tree().create_timer(0.1).timeout
		collision_sensor.set_disabled(false)
func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.get_animation() == "retract":
		anim.play("idle")


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "attack" and anim.get_frame() == 2:
		collision_hit_area.set_disabled(false)
	
	if anim.get_animation() == "retract" and anim.get_frame() == 3:
		collision_hit_area.set_disabled(true)

func _on_hit_area_body_entered(body: CharacterBody2D) -> void:
	if not body.death:
		body.gettingHit = true
		body.lives -= 1
		var body_direction = global_position.direction_to(body.global_position)
		body.velocity = body_direction * -300
