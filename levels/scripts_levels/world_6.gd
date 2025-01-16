extends Node2D

@onready var player: Node2D = $player
var scene_game_over = preload("res://hud/game_over.tscn")
var scene_you_win = preload("res://hud/you_win_hud.tscn")

var has_executed_once = false
@onready var timer: Timer = $Timer
@onready var coins: Node2D = $coins

func _process(delta: float) -> void:
	if player:
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


func _on_move_camera_1_body_entered(body: Node2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(100, 120))

	
func _on_move_camera_1_body_exited(body: Node2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, 0))


func _on_move_camera_0_body_entered(body: Node2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_limit_bottom(450)


func _on_move_camera_2_body_entered(body: Node2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(50, 100))


func _on_move_camera_2_body_exited(body: Node2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, 0))


func _on_pinchos_trap_body_entered(body: Node2D) -> void:
	body.gettingHit = true
	await get_tree().create_timer(0.2).timeout
	body.lives = 0


func _on_you_win_area_body_entered(body: Node2D) -> void:
	if body:
		var time_left = timer.wait_time - timer.get_time_left()
		SaveGameProcesor.timer_level = round(time_left * 100) / 100
		timer.stop()
		var all_coins_obtained = missing_coin(coins.get_child_count())
		SaveGameProcesor.save_best_time("level_6", all_coins_obtained, no_hit())
		var level_split = name.split("_")
		var next_level = int(level_split[1]) + 1
		SaveGameProcesor.save_data_levels("level_" + level_split[1], "level_" + str(next_level))
		var instantia = scene_you_win.instantiate()
		add_child(instantia)
		instantia.showHud(true)

func missing_coin(coin: int):
	if coin == 0:
		return true
	else:
		return false

func no_hit():
	var chilldrens = get_children()
	for i in chilldrens:
		if i.name == "player":
			var player_chillds = i.get_children()
			if player_chillds[0].lives == 5:
				return true
			else:
				return false
