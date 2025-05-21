extends Area3D

@export var can_teleport: bool = true
@export var destination: Room
@export var origin: Room
@export var location_point: LocationPoint

var _player_inside_area: bool = false

func teleport() -> void:
	SignalManager.on_room_change.emit(origin,destination,location_point)
	

func _input(_event: InputEvent) -> void:
	if (Input.is_action_just_pressed("interact") and can_teleport and _player_inside_area):
		if (!destination):
			push_error(get_parent().name + " has no destination")
			return
		if (!origin):
			push_error(get_parent().name + " has no origin specified origin")
			return
		if (!location_point):
			push_error(get_parent().name + "has no teleport location")
			return
		teleport()

func _on_body_exited(body:Node3D) -> void:
	if (body is Player):
		_player_inside_area = false

func _on_body_entered(body:Node3D) -> void:
	if (body is Player):
		_player_inside_area = true
