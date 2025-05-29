extends Control

func _ready() -> void:
	SignalManager.on_player_defeated.connect(dead_player)
	SignalManager.on_player_stat_updated.connect(update_stat)
	SignalManager.on_entered_battle.connect(init_stats)
	SignalManager.on_player_select.connect(make_select)
	SignalManager.on_player_unselect.connect(make_unselect)
	for fighter in BattleManager._players:
		update_stat(fighter)
		if (fighter.get_dead()):
			dead_player(fighter)


func dead_player(fighter) -> void:
	var node: Control = find_child(fighter.name.to_lower())
	if (!node):
		push_error(fighter.get_given_name() + " isn't a valid player????")
		return
	node.self_modulate = Color8(41,41,41,41)
	node.get_child(0).self_modulate = Color8(41,41,41,41)

func make_select(fighter) -> void:
	var node: ColorRect = find_child(fighter.name.to_lower()+"_select")
	node.visible = true

func make_unselect(fighter) -> void:
	var node: ColorRect = find_child(fighter.name.to_lower()+"_select")
	node.visible = false

func update_stat(fighter) -> void:
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
