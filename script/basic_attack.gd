extends Move

@export var damage: int = 1
@export var accuracy: int = 100
@export var armor_pierce: int = 0

func move() -> void:
	if (has_strategy()):
		var strategy: Strategy = get_random_strategy()
		strategy.determine_target()
		set_target(strategy.get_target())
	
	DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on " + get_target().get_given_name())
	print(BattleManager.get_top_fighter().get_given_name() + " used " + name + " on " + get_target().get_given_name())
	
	if (!accuracy_test(accuracy)):
		DialogueManager.add_battle_dialogue(name + " missed")
		print(name + " missed")
		return
	
	get_target().take_damage(damage,armor_pierce)

