extends Control

func _ready() -> void:
	SignalManager.on_player_defeated.connect(dead_player)
	SignalManager.on_player_stat_updated.connect(update_stat)
	SignalManager.on_entered_battle.connect(init_stats)

func dead_player(fighter: PlayerFighter) -> void:
	var node: Control = find_child(fighter.name.to_lower())
	if (!node):
		push_error(fighter.get_given_name() + " isn't a valid player????")
		return
	node.self_modulate = Color8(41,41,41,41)
	node.get_child(0).self_modulate = Color8(41,41,41,41)


func update_stat(fighter: PlayerFighter) -> void:
	var node: Control = find_child(fighter.name.to_lower()) #This not shown
	if (!node):
		push_error(fighter.get_given_name() + " isn't a valid player????")
		return
	var label = node.get_child(0).get_child(1).get_child(1)
	if (label is Label):
		label.text = str(fighter.get_health())

	label = node.get_child(0).get_child(2).get_child(1)
	if (label is Label):
		label.text = str(fighter.get_special())

func init_stats(_node: Node3D) -> void:
	for player in BattleManager._players:
		update_stat(player)
