extends Effect

func effect() -> void:
	get_fighter().add_adjusted_defense(strength)

func reverse_effect() -> void:
	get_fighter().remove_adjusted_defense(strength)
