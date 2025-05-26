extends Effect

@export var is_debuff: bool

func effect() -> void:
	if (!is_debuff):
		get_target().add_adjusted_speed(strength)
	else:
		get_target().remove_adjusted_speed(strength)

func reverse_effect() -> void:
	if (!is_debuff):
		get_target().remove_adjusted_speed(strength)
	else:
		get_target().add_adjusted_speed(strength)
	queue_free()
