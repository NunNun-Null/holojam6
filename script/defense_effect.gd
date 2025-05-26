extends Effect

func _ready() -> void:
	given_effect_name = "defense"
func effect() -> void:
	if (!is_debuff):
		get_target().add_adjusted_defense(strength)
	else:
		get_target().remove_adjusted_defense(strength)

func reverse_effect() -> void:
	if (!is_debuff):
		get_target().remove_adjusted_defense(strength)
	else:
		get_target().add_adjusted_defense(strength)
	queue_free()
