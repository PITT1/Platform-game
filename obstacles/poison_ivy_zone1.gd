extends Area2D 



func _on_body_entered(body: Node2D) -> void:
	body.gettingHit = true
	body.lives -= 1
	body.velocity.y = -200
	
