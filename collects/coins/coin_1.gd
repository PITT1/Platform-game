extends Node2D
@onready var coin_drop_sound: AudioStreamPlayer2D = $coin_drop_sound
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("coin")

func _on_area_2d_body_entered(body: Node2D) -> void:
	coin_drop_sound.play()
	await get_tree().create_timer(0.08).timeout
	queue_free()
	
	if body:
		pass
