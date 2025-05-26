extends Effect

func _ready() -> void:
	given_effect_name = "attack"

func effect() -> void:
	if (!is_debuff):
		get_target().add_bonus_damage(strength)
	else:
		get_target().remove_bonus_damage(strength)

func reverse_effect() -> void:
	if (!is_debuff):
		get_target().remove_bonus_damage(strength)
	else:
		get_target().add_bonus_damage(strength)
	queue_free()
