extends Area3D

@export var enemies: Array[PackedScene]

func _ready() -> void:
	if (SceneManager.has_completed_battle(self)):
		queue_free()

func _on_body_entered(body:Node3D) -> void:
	if (body is Player):
		var team: Array = UtilitiesManager.convert_to_enemies(enemies)
		BattleManager.create_enemies(team)
		BattleManager.start_battle()
		call_deferred("switch_to_battle")
		call_deferred("queue_free")

func switch_to_battle() -> void:
	SignalManager.on_entered_battle.emit(self)
	BattleManager.switch_to_battle()
