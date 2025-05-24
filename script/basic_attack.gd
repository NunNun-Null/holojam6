extends Move

@export var damage: int = 1
@export var accuracy: int = 100
@export var armor_pierce: int = 0

func move() -> void:
	if (has_strategy()):
		var strategy: Strategy = get_random_strategy()
		strategy.determine_target()
		set_target(strategy.get_target())
	print("used " + name + " on " + get_target().get_given_name())
	if (!accuracy_test(accuracy)):
		print(name + " missed")
		return
	get_target().take_damage(damage)
	print(get_target().get_given_name() + " took damage. total health " + str(get_target().get_health()))

