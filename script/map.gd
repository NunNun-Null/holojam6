extends Node3D

func _ready() -> void:
	var camera: Camera3D = GlobalManager.get_player().find_child("Camera")
	camera.make_current()
	print("Map Loaded")
	SignalManager.on_map_ready.emit()
