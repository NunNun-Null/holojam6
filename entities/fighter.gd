extends Node
class_name Fighter

@export var moves: Node
@export var effects: Node

signal on_turn()
signal turn_complete()

var _speed: int
var _health: int
var _defense: int

func _init(health: int, defense: int, speed: int) -> void:
    _speed = speed
    _health = health
    _defense = defense

func get_speed() -> int:
    return _speed

func get_health() -> int:
    return _health

func get_defense() -> int:
    return _defense    

func start_turn() -> void: 
    push_error(name + " is missing a start_turn() method")

func apply_effects() -> void:
    for effect in effects.get_children():
        if (effect is Effect):
            effect.apply_effect()

func reset_effects() -> void:
    for effect in effects.get_children():
        if (effect is Effect):
            if (!effect.get_perm()):
                effect.apply_effect()
