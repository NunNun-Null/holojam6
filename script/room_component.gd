extends Node3D
class_name Room

func _ready() -> void:
	visible = false

func set_player_location(location: Node3D) -> void:
	GlobalManager.get_player().global_position = location.global_position
