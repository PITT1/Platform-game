extends Control
var pause_hud = preload("res://hud/pause_hud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	var instantia = pause_hud.instantiate()
	add_sibling(instantia)
	get_tree().paused = true
