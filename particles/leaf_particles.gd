extends CPUParticles2D
@onready var player: Node2D = $"../player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player.global_position)
