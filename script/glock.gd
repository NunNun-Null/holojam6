extends Move

@export var damage: int = 1

func move() -> void:
	var strategy: Strategy = get_random_strategy()
	strategy.determine_target()
	var fighter: Fighter = strategy.get_target()
	print("used " + name + " on " + fighter.name)
	fighter.take_damage(damage)
	print(fighter.name + " took damage. total health " + str(fighter.get_health()))

