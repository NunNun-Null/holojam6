extends Strategy

@export var given_target_name: String 
func determine_target() -> void:
	var target: Fighter
	
	for player in BattleManager._players:
		if (player.get_given_name() == given_target_name):
			target = player
			break
			
	if (!target):
		for enemy in BattleManager._enemies:
			if (enemy.get_given_name() == given_target_name):
				target = enemy
				break
	set_target(target)
