extends Strategy

@export var switch_to_mark: bool = false

func determine_target() -> void:
	var target: Fighter
	target = BattleManager.get_player_fighter(0)
	for i in range(BattleManager.get_players_size()-1):
		if (BattleManager.get_player_fighter(i).get_health() > target.get_health() and !BattleManager.get_player_fighter(i).get_dead() and (!BattleManager.get_player_fighter(i).get_stun() or (!BattleManager.get_player_fighter(i).get_mark() and switch_to_mark))):
			target = BattleManager.get_player_fighter(i)
	set_target(target)
