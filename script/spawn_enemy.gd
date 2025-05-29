extends Move

@export var spawn: Array[PackedScene] #Note Cannot spawn self
@export var random: bool = false
@export var amount: int = 1

func move() -> void:
	DialogueManager.add_battle_dialogue(get_parent().get_parent().get_given_name() + " used " + name)
	SignalManager.on_dialogue_pushed.emit()
	if (!random):
		for enemy in spawn:
			if (BattleManager._enemies.size() >= 4):
				return
			if (enemy):
				var fighter = enemy.instantiate()
				get_tree().root.add_child(fighter)
				DialogueManager.add_battle_dialogue(fighter.get_given_name() + " joined the battle")
				SignalManager.on_dialogue_pushed.emit()
				BattleManager.add_fighter(fighter)
	else:
		for i in range(amount):
			if (BattleManager._enemies.size() >= 4):
				return
			var fighter = spawn.pick_random().instantiate()
			get_tree().root.add_child(fighter)
			DialogueManager.add_battle_dialogue(fighter.get_given_name() + " joined the battle")
			SignalManager.on_dialogue_pushed.emit()
			BattleManager.add_fighter(fighter)
