extends Node
class_name Strategy

var _target: Fighter

func determine_target() -> void: 
	push_error(name + " is missing a determine_target() method")

func set_target(target: Fighter) -> void:
	_target = target
	
func get_target() -> Fighter:
	return _target
