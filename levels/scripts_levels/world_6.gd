extends Node2D




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
