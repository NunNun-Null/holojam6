extends Effect


func reapply(fighter: Fighter) -> void:
	fighter.remove_health(strength)

func reverse_effect() -> void:
	queue_free()