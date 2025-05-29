extends Control

func _ready() -> void:
	SignalManager.on_order_updated.connect(update_order)
	update_order(BattleManager._round)

func update_order(list: Array) -> void:
	$PanelContainer/Text.text = "Round " + str(BattleManager.get_current_round()) + "\n"
	$PanelContainer/Text.text += "> " + list[list.size()-1].get_given_name() + "\n"
	for index in range(list.size()-1):
		$PanelContainer/Text.text += list[list.size()-index-2].get_given_name() + "\n"
