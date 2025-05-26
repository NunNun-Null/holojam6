extends Effect

func effect() -> void:
	get_target().set_mark(true)

func reverse_effect() -> void:
	get_target().set_mark(false)
	