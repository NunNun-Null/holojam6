extends Effect

func effect() -> void:
	get_fighter().set_mark(true)
	get_fighter().add_damage_multipler(strength+2)
	get_fighter().add_adjusted_defense(strength+3)

func reverse_effect() -> void:
	get_fighter().set_mark(false)
	get_fighter().remove_damage_multipler(strength+2)
	get_fighter().remove_adjusted_defense(strength+3)
