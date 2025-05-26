extends Move

@export var damage: int = 1
@export var accuracy: int = 100
@export var armor_pierce: int = 0

func move() -> void:
	if (has_strategy()):
		var strategy: Strategy = get_random_strategy()
		strategy.determine_target()
		set_target(strategy.get_target())
	
	var added_damage: int = 0
	var added_accuracy: int = 0

	if (get_parent().get_parent() is Fighter):
		added_damage = get_parent().get_parent().get_bonus_damage()
		added_accuracy = get_parent().get_parent().get_bonus_accuracy()
	DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on " + get_target().get_given_name())
	print(BattleManager.get_top_fighter().get_given_name() + " used " + name + " on " + get_target().get_given_name())
	
	if (!accuracy_test(accuracy+added_accuracy)):
		DialogueManager.add_battle_dialogue(name + " missed")
		print(name + " missed")
		return
	
	get_target().take_damage(damage+added_damage,armor_pierce)

