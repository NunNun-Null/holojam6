extends Effect

func _ready() -> void:
	given_effect_name = "stun"

func effect() -> void:
	for eff in get_target().effects.get_children():
		if (eff is Effect):
			if (eff.given_effect_name == "stun"):
				eff.duration = self.duration
				queue_free()
				return
	get_target().set_stun(true)

func reverse_effect() -> void:
	get_target().set_stun(false)
	queue_free()