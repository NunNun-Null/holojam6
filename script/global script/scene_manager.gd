extends Node

var battle_progression: Dictionary = {}

var current_battle: Node3D

func _ready() -> void:
	SignalManager.on_entered_battle.connect(add_battle)
	SignalManager.on_room_change.connect(change_room)

func change_room(origin: Room, destination: Room, location: Node3D) -> void:
	origin.visible = false
	destination.visible = true
	destination.reset_room()
	destination.set_player_location(location)

func add_battle(node: Node3D) -> void:
	var battle: bool = battle_progression.has(node.name)
	if (battle):
		return
	battle_progression.assign({node.name:true})


func has_completed_battle(node: Node3D) -> bool:
	if (!battle_progression.has(node.name)):
		return false
	return battle_progression.get(node.name)
