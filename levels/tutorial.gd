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
		var data = SaveGameProcesor.load_game()
		var data_dict: Dictionary = JSON.parse_string(data)
		var new_data = data_dict.duplicate()
		new_data["level_1"]["is_level_blocked"] = false
		new_data["tutorial"]["is_level_pass"] = true
		SaveGameProcesor.save_game(JSON.stringify(new_data))
		
		
		var instantia = scene_you_win.instantiate()
		add_child(instantia)
		instantia.showHud(true)
