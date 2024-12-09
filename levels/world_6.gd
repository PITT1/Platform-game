extends Node2D

@export var is_level_pass: bool = false 
@export var is_level_bloqued: bool = false
@onready var player: Node2D = $player

var scene_game_over = preload("res://hud/game_over.tscn")
var scene_you_win = preload("res://hud/you_win_hud.tscn")

var has_executed_once = false

func _process(delta: float) -> void:
	var playerChild = player.get_children()
	if not has_executed_once:
		if playerChild[0].lives < 1:
			var instantia = scene_game_over.instantiate()
			add_child(instantia)
			instantia.showHud(true)
			set_has_executed_once()
	if delta:
		pass

func set_has_executed_once():
	has_executed_once = true

func _on_win_area_body_entered(body: Node2D) -> void:
	if body:
		is_level_pass = true
		var instantia = scene_you_win.instantiate()
		add_child(instantia)
		instantia.showHud(true)


func _on_death_zone_body_entered(body: Node2D) -> void:
	body.lives = 0
