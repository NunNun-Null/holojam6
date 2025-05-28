extends Effect

func _ready() -> void:
	given_effect_name = "mental protection"

func effect() -> void:
	for eff in get_target().effects.get_children():
		if (eff is Effect):
			if (eff.given_effect_name == "mental protection"):
				eff.duration = self.duration
				queue_free()
				return
	get_target().make_perfect_protected()

func reverse_effect() -> void:
	get_target().reset_perfect_protected()
	queue_free()