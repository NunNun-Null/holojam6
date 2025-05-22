extends Move

func move() -> void:
	var strategy: Strategy = get_random_strategy()
	strategy.determine_target()
	var fighter: PlayerFighter = strategy.get_target()
	print("used " + name + " on " + fighter.name)
	
