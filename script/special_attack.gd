extends Move

func move() -> void:
	DialogueManager.add_battle_dialogue("> " + BattleManager.get_top_fighter().get_given_name() + " used " + name + " on everyone")
	SignalManager.on_dialogue_pushed.emit()
	for player in BattleManager._players:
		if (player.get_dead()):
			continue
		player.test_perfect_protected()
