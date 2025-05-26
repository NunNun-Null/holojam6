extends Effect

@export var is_debuff: bool

func effect() -> void:
	if (!is_debuff):
		get_target().add_bonus_accuracy(strength)
	else:
		get_target().remove_bonus_accuracy(strength)

func reverse_effect() -> void:
	if (!is_debuff):
		get_target().remove_bonus_accuracy(strength)
	else:
		get_target().add_bonus_accuracy(strength)
	queue_free()
