extends Node

func _ready() -> void:
	SignalManager.on_room_change.connect(change_room)

func change_room(origin: Room, destination: Room, location: Node3D) -> void:
	origin.visible = false
	destination.visible = true
	destination.reset_room()
	destination.set_player_location(location)
