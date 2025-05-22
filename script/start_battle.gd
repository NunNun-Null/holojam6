extends Area3D

@export var enemies: Array[PackedScene]

var BATTLE = preload("res://area/battle.tscn")

func _on_body_entered(body:Node3D) -> void:
	if (body is Player):
		var team: Array[EnemyFighter] = UtilitiesManager.convert_to_enemies(enemies)
		await get_tree().create_timer(3).timeout
		print("enemy team created")

		BattleManager.create_enemies(team)
		await get_tree().create_timer(3).timeout
		print("enemies created")

		var battle = BATTLE.instantiate()
		get_tree().root.add_child(battle)
		await get_tree().create_timer(3).timeout
		print("battlefield created")

		battle.update_positions()
		await get_tree().create_timer(3).timeout
		print("establishing battle")
		battle.start()
		get_tree().change_scene_to_file("res://area/battle.tscn")
