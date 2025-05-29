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

	if (!self_move and !for_everyone):
		DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on " + get_target().get_given_name())
	elif (!self_move and for_everyone):
		DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on all targets")
	else:
		DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on themselves")
	
	if (for_everyone):
		var list
		if (is_for_allies()):
			list = BattleManager._players
		else:
			list = BattleManager._enemies

		for enemy in list:
			if (enemy is PlayerFighter):
				if (enemy.get_dead()):
					continue
			set_target(enemy)
			if (!accuracy_test((accuracy+added_accuracy)) and !max_accuracy):
				DialogueManager.add_battle_dialogue(name + " missed for " + get_target().get_given_name())
				SignalManager.on_dialogue_pushed.emit()
				continue
			if (effects.size() != strengths.size() or effects.size() != durations.size() or effects.size() != is_debuffs.size()):
				push_error(name + " has unmatched status effects. fix it")
				continue
			for i in range(effects.size()):
				var eff = effects[i].instantiate()
				if (eff is not Effect):
					push_error(eff.name + " is not an Effect")
					continue
				eff.strength = strengths[i]
				eff.duration = durations[i]
				eff.is_debuff = is_debuffs[i]
				eff.set_host(get_parent().get_parent())
				if (((enemy is PlayerFighter and get_parent().get_parent() is not PlayerFighter) or (enemy is EnemyFighter and get_parent().get_parent() is not EnemyFighter)) and enemy.is_defended()):
					eff.set_target(enemy.get_defended())
				else:
					eff.set_target(enemy)
				eff.effect()
				eff.get_target().effects.add_child(eff)
				


				var content: String = eff.get_target().get_given_name() + " is effected with " + eff.given_effect_name

				if (eff.is_debuff):
					content += " debuff for " + str(eff.duration) + " turns"
				if (!eff.is_debuff):
					content += " buff for " + str(eff.duration) + " turns"
				
				DialogueManager.add_battle_dialogue(content)

			if (damage > 0):
				get_target().take_damage(damage+added_damage,armor_pierce)
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
			var eff = effects[i].instantiate()
			if (eff is not Effect):
				push_error(eff.name + " is not an Effect")
				return
			eff.strength = strengths[i]
			eff.duration = durations[i]
			eff.is_debuff = is_debuffs[i]
			eff.set_host(get_parent().get_parent())
			if (((get_target() is PlayerFighter and get_parent().get_parent() is not PlayerFighter) or (get_target() is EnemyFighter and get_parent().get_parent() is not EnemyFighter)) and get_target().is_defended()):
				print("opposing sides")
				eff.set_target(get_target().get_defended())
			else:
				print("same sides")
				eff.set_target(get_target())
			eff.effect()
			eff.get_target().effects.add_child(eff)
			if (eff.given_effect_name == "defended"):
				for node in get_target().effects.get_children():
					if (node is Effect):
						if (node.given_effect_name == "defended"):
							DialogueManager.add_battle_dialogue(node.get_target().get_given_name() + "'s defended effect ended")
							node.reverse_effect()
			if (eff.given_effect_name == "stun" and eff.get_target().immune_to_stun):
				eff.reverse_effect()
				DialogueManager.add_battle_dialogue(eff.get_target().get_given_name() + " resisted stun")
			else:
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
