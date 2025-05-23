extends Move

@export var damage: int = 1
@export var accuracy: int = 100
@export var armor_pierce: int = 0

func move() -> void:
	var strategy: Strategy = get_random_strategy()
	strategy.determine_target()
	var fighter: Fighter = strategy.get_target()
	print("used " + name + " on " + fighter.name)
	if (!accuracy_test(accuracy)):
		print(name + " missed")
		return
	fighter.take_damage(damage)
	print(fighter.name + " took damage. total health " + str(fighter.get_health()))

