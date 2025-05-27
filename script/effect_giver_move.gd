extends Move

@export var effects: Array[PackedScene]
@export var strengths: Array[int]
@export var durations: Array[int]
@export var is_debuffs: Array[bool]

@export var damage: int = 0
@export var accuracy: int = 100
@export var armor_pierce: int = 0
@export var max_accuracy: bool = false
func move() -> void:
	var added_damage = get_parent().get_parent().get_bonus_damage()
	var added_accuracy = get_parent().get_parent().get_bonus_accuracy()
	
	if (has_strategy()):
		var strategy: Strategy = get_random_strategy()
		strategy.determine_target()
		set_target(strategy.get_target())

	if (!self_move):
		DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on " + get_target().get_given_name())
	else:
		DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on themselves")
	
	if (for_everyone):
		var list
		if (is_for_allies()):
			list = BattleManager._players
		else:
			list = BattleManager._enemies

		for enemy in list:
			if (!accuracy_test((accuracy+added_accuracy)) and !max_accuracy):
				DialogueManager.add_battle_dialogue(name + " missed for " + enemy.get_given_name())
				SignalManager.on_dialogue_pushed.emit()
				continue


			if (effects.size() != strengths.size() or effects.size() != durations.size() or effects.size() != is_debuffs.size()):
				push_error(name + " has unmatched status effects. fix it")
				continue
			for i in range(effects.size()):
				var eff = effects.get(i).instantiate()
				if (eff is not Effect):
					push_error(eff.name + " is not an Effect")
					continue
				eff.strength = strengths.get(i)
				eff.duration = durations.get(i)
				eff.is_debuff = is_debuffs.get(i)
				eff.set_host(get_parent().get_parent())
				eff.set_target(enemy)
				enemy.effects.add_child(eff)
				eff.effect()

				var content: String = enemy.get_given_name() + " is effected with " + eff.given_effect_name

				if (eff.is_debuff):
					content += " debuff for " + str(eff.duration) + " turns"
				if (!eff.is_debuff):
					content += " buff for " + str(eff.duration) + " turns"
				
				DialogueManager.add_battle_dialogue(content)

			if (damage > 0):
				enemy.take_damage(damage+added_damage,armor_pierce)
			else:
				SignalManager.on_dialogue_pushed.emit()

	else:
		if (!accuracy_test((accuracy+added_accuracy))):
			DialogueManager.add_battle_dialogue(name + " missed")
			SignalManager.on_dialogue_pushed.emit()
			return

		if (effects.size() != strengths.size() or effects.size() != durations.size() or effects.size() != is_debuffs.size()):
			push_error(name + " has unmatched status effects. fix it")
			return
		for i in range(effects.size()):
			var eff = effects.get(i).instantiate()
			if (eff is not Effect):
				push_error(eff.name + " is not an Effect")
				return
			eff.strength = strengths.get(i)
			eff.duration = durations.get(i)
			eff.is_debuff = is_debuffs.get(i)
			eff.set_host(get_parent().get_parent())
			eff.set_target(get_target())
			get_target().effects.add_child(eff)
			eff.effect()
			var content: String = get_target().get_given_name() + " is effected with " + eff.given_effect_name
			if (eff.is_debuff):
				content += " debuff for " + str(eff.duration) + " turns"
			if (!eff.is_debuff):
				content += " buff for " + str(eff.duration) + " turns"
			DialogueManager.add_battle_dialogue(content)

		if (damage > 0):
			get_target().take_damage(damage+added_damage,armor_pierce)
		else:
			SignalManager.on_dialogue_pushed.emit()
