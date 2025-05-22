extends Node3D
class_name Fighter

@export var moves: Node
@export var effects: Node

var _speed: int
var _health: int
var _defense: int

func get_speed() -> int:
    return _speed

func get_health() -> int:
    return _health

func get_defense() -> int:
    return _defense    

func set_health(amount: int) -> void:
    _health = amount

func set_defense(amount: int) -> void:
    _defense = amount

func set_speed(amount: int) -> void:
    _speed = amount


func start_turn() -> void:
    push_error(name + " is missing a start_turn() method")
    SignalManager.on_move_completed.emit()

func apply_effects() -> void:
    for effect in effects.get_children():
        if (effect is Effect):
            effect.apply_effect()

func reset_effects() -> void:
    for effect in effects.get_children():
        if (effect is Effect):
            if (!effect.get_perm()):
                effect.apply_effect()
