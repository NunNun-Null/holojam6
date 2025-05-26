extends Effect

func effect() -> void:
	get_target().set_stun(true)

func reverse_effect() -> void:
	get_target().set_stun(false)
