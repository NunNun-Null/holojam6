extends Strategy

func determine_target() -> void:
	var target: Array
	for player in BattleManager._players:
		if (player.get_mark() and !player.get_dead()):
			target.append(player)
	if (target.is_empty()):
		for player in BattleManager._players:
			if (!player.get_dead()):
				target.append(player)
	set_target(target.pick_random())
