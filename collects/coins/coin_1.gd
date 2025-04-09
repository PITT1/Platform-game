extends Node2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var drop_particles: PackedScene

func _ready() -> void:
	anim.play("coin")

func _on_area_2d_body_entered(body: Node2D) -> void:
	SaveGameProcesor.coins_count += 1
	var instantia = drop_particles.instantiate()
	add_sibling(instantia)
	instantia.set_global_position(get_global_position())
	print(instantia.global_position)
	queue_free()
	
	if body:
		pass
