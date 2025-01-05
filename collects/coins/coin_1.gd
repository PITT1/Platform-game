extends Node2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var drop_particles: PackedScene

func _ready() -> void:
	anim.play("coin")

func _on_area_2d_body_entered(body: Node2D) -> void:
	var instantia = drop_particles.instantiate()
	add_sibling(instantia)
	instantia.global_position = global_position
	queue_free()
	
	if body:
		pass
