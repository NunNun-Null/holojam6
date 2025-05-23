extends Node3D

func _ready() -> void:
	SignalManager.on_enemy_defeated.connect(update_positions)
	SignalManager.on_switch_to_map.connect(close_battle)
	close_battle()
	
func update_positions() -> void:
	visible = true
	for index in range(BattleManager.get_enemies_size()):
		BattleManager.get_enemy_fighter(index).global_position = $"Enemy Positions".get_child(index).global_position

func close_battle() -> void:
	visible = false