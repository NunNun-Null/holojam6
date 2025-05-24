extends Move

@export var strength: int = 1


func move() -> void:
	if (has_strategy()):
		var strategy: Strategy = get_random_strategy()
		strategy.determine_target()
		set_target(strategy.get_target())
	
	print(BattleManager.get_top_fighter().get_given_name() + " used " + name + " on " + get_target().get_given_name())
	
	if (BattleManager.get_top_fighter().get_given_name() == get_target().get_given_name()):
		DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on themselves")
	else:
		DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on " + get_target().get_given_name())
	
	get_target().heal(strength)
