extends Area3D

func _on_body_entered(body:Node3D) -> void:
	if (body is Player):
		PlayerManager.reset_team()


func _on_body_exited(_body:Node3D) -> void:
	pass # Replace with function body.
