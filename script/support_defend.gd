extends Strategy


func determine_target() -> void:
	var target: Array
	for enemy in BattleManager._enemies:
		if (enemy.get_given_name() == "Pink Tainted Memory" or enemy.get_given_name() == "Blue Tainted Memory" and !enemy.is_defended()):
			target.append(enemy)
	if (target.is_empty()):
		for enemy in BattleManager._enemies:
			if (enemy != get_parent().get_parent()):
				target.append(enemy)
	set_target(target.pick_random())
