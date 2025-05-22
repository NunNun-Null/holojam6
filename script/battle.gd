extends Node3D

func start() -> void:
	await get_tree().create_timer(3).timeout
	print("starting battle")
	BattleManager.start_round()
	
func update_positions() -> void:
	for index in range(BattleManager.get_players_size()):
		BattleManager.get_player_fighter(index).global_position = $"Player Positions".get_child(index).global_position
	for index in range(BattleManager.get_enemies_size()):
		BattleManager.get_enemy_fighter(index).global_position = $"Enemy Positions".get_child(index).global_position
