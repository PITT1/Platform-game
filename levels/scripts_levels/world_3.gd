extends Node2D

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


func _on_win_area_body_entered(body: CharacterBody2D) -> void:
	if body:
		SaveGameProcesor.save_data_levels("level_3", "level_4")
		var instantia = scene_you_win.instantiate()
		add_child(instantia)
		instantia.showHud(true)


func _on_move_camera_area_body_entered(body: CharacterBody2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, 0))
	pcamPlayer.set_limit_bottom(450)


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, 100))


func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, 0))


func _on_death_zone_body_entered(body: CharacterBody2D) -> void:
	body.lives = 0
