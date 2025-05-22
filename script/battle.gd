extends Node3D

func _ready() -> void:
	SignalManager.on_enemy_defeated.connect(update_positions)
	
func update_positions() -> void:
	for index in range(BattleManager.get_enemies_size()):
		BattleManager.get_enemy_fighter(index).global_position = $"Enemy Positions".get_child(index).global_position
