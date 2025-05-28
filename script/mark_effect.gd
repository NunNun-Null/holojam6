extends Effect

func _ready() -> void:
	given_effect_name = "marked"
	
func effect() -> void:
	for eff in get_target().effects.get_children():
		if (eff is Effect):
			if (eff.given_effect_name == "marked" and eff != self):
				eff.duration = self.duration
				print("already found")
				queue_free()
				return

	get_target().set_mark(true)

func reverse_effect() -> void:
	get_target().set_mark(false)
	queue_free()
