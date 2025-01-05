extends CPUParticles2D
@onready var coin_drop_sound: AudioStreamPlayer2D = $coin_drop_sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true
	coin_drop_sound.play()



func _on_finished() -> void:
	queue_free()
