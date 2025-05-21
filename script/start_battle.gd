extends Area3D

@export var enemies: Array[PackedScene]

var BATTLE = preload("res://area/battle.tscn")

func _on_body_entered(body:Node3D) -> void:
	if (body is Player):
		BattleManager.create_enemies(UtilitiesManager.convert_to_array(enemies))
		var battle = BATTLE.instantiate()
		battle.update_positions()
		print("starting battle")
		get_tree().change_scene_to_file(battle)