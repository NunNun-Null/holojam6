extends Strategy

@export var switch_to_enemies: bool = false

func determine_target() -> void:
	var target: Fighter
	if (!switch_to_enemies):
		target = BattleManager.get_player_fighter(0)
		for i in range(BattleManager.get_players_size()-1):
			if (BattleManager.get_player_fighter(i).get_health() < target.get_health() and !BattleManager.get_player_fighter(i).get_dead()):
				target = BattleManager.get_player_fighter(i)
	else:
		target = BattleManager.get_enemy_fighter(0)
		for i in range(BattleManager.get_enemies_size()-1):
			if (BattleManager.get_enemy_fighter(i).get_health() < target.get_health()):
				target = BattleManager.get_enemy_fighter(i)
	set_target(target)
