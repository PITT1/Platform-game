extends Area2D 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	body.gettingHit = true
	body.lives -= 1
	body.velocity.y = -200
	print("te hace daño")
	
