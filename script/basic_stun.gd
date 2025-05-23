extends Effect

func effect() -> void:
	get_fighter().set_stun(true)

func reverse_effect() -> void:
	get_fighter().set_stun(false)
