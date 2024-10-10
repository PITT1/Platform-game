extends Node2D
@onready var player: Node2D = $player
@onready var leaf_particles: CPUParticles2D = $leaf_particles



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	print(player.get_position())
