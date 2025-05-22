extends Area3D

@export var enemies: Array[PackedScene]


func _on_body_entered(body:Node3D) -> void:
	if (body is Player):
		var team: Array[EnemyFighter] = UtilitiesManager.convert_to_enemies(enemies)
		BattleManager.create_enemies(team)
		BattleManager.start_battle()
		call_deferred("switch_to_battle")
	
func switch_to_battle() -> void:
	BattleManager.switch_to_battle()
	BattleManager.get_battle_map().update_positions()
