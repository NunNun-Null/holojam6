extends Move

@export var duration: int = 1
@export var strength: int = 1
@export var damage: int = 0
@export var accuracy: int = 100
@export var effects: Array[PackedScene]

@export var apply_immediate: bool = false
func move() -> void:
	var strategy: Strategy = get_random_strategy()
	strategy.determine_target()
	print("used " + name + " on " + strategy.get_target().name)

	if (!accuracy_test(accuracy)):
		print(name + " missed")
		return
	strategy.get_target().take_damage(damage)

	for effect in effects:
		var eff = effect.instantiate()
		if (eff is Effect):
			eff.set_duration(duration)
			eff.set_strength(strength)
			strategy.get_target().add_effect(eff)
			if (apply_immediate):
				eff.target = strategy.get_target()
				eff.active = true 
				eff.effect()
			print(strategy.get_target().name + " is hit with " + eff.name)