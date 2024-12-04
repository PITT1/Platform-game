extends Node2D




func _on_camera_move_1_body_entered(body: CharacterBody2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_limit_bottom(400)
	pcamPlayer.set_follow_offset(Vector2(0, 0))


func _on_camera_move_2_body_entered(body: CharacterBody2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, 140))


func _on_camera_move_3_body_entered(body: CharacterBody2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, -100))


func _on_camera_move_4_body_entered(body: CharacterBody2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, 100))


func _on_camera_move_5_body_entered(body: CharacterBody2D) -> void:
	var pcamPlayer = body.get_child(5).get_child(0)
	pcamPlayer.set_follow_offset(Vector2(0, 0))


func _on_death_zone_body_entered(body: CharacterBody2D) -> void:
	body.lives -= 5
