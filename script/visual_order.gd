extends Control

func _ready() -> void:
	SignalManager.on_order_updated.connect(update_order)
	update_order(BattleManager._round)

func update_order(list: Array[Fighter]) -> void:
	$PanelContainer/Text.text = "> " + list.get(list.size()-1).get_given_name() + "\n"
	for index in range(list.size()-1):
		$PanelContainer/Text.text += list.get(list.size()-index-2).get_given_name() + "\n"
