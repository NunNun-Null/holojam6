extends Node

var battle_progression: Dictionary = {}

var current_battle: String

func _ready() -> void:
	SignalManager.on_entered_battle.connect(add_battle)
	SignalManager.on_room_change.connect(change_room)
	SignalManager.on_player_lost.connect(remove_battle)

func change_room(origin, destination, location: Node3D) -> void:
	origin.visible = false
	destination.visible = true
	destination.reset_room()
	destination.set_player_location(location)
	PlayerManager.room = destination.name

func add_battle(node: Node3D) -> void:
	var battle: bool = battle_progression.has(node)
	if (battle):
		return
	current_battle = node.name
	battle_progression.merge({node.name:true})

func remove_battle() -> void:
	var battle: bool = battle_progression.has(current_battle)
	if (battle):
		battle_progression.erase(current_battle)
		current_battle = ""
	return

func has_completed_battle(node: Node3D) -> bool:
	if (!battle_progression.has(node.name)):
		return false
	return battle_progression.get(node.name)
