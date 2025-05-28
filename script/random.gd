extends Strategy

@export var switch_to_enemies: bool = false

func determine_target() -> void:
	var target: Array
	if (!switch_to_enemies):
		target = BattleManager._enemies
	else:
		for player in BattleManager._players:
			if (!player.get_dead()):
				target.append(player)
	set_target(target.pick_random())
