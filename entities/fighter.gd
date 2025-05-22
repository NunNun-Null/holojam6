extends Node3D
class_name Fighter

@export var moves: Node
@export var effects: Node

var _speed: int
var _health: int
var _defense: int

var _max_health: int 

var _adjusted_speed: int
var _adjusted_defense: int

func get_speed() -> int:
    return _speed + _adjusted_speed

func get_health() -> int:
    return _health

func get_max_health() -> int:
    return _max_health

func get_defense() -> int:
    return _defense + _adjusted_defense

func get_raw_speed() -> int:
    return _speed

func get_raw_defense() -> int:
    return _defense

func add_adjusted_speed(amount: int) -> void:
    _adjusted_speed += amount

func remove_adjusted_speed(amount: int) -> void:
    _adjusted_speed -= amount

func add_adjusted_defense(amount: int) -> void:
    _adjusted_defense += amount

func remove_adjusted_defense(amount: int) -> void:
    _adjusted_defense -= amount

func add_max_health(amount: int) -> void:
    _max_health += amount

func set_max_health(amount: int) -> void:
    _max_health = amount

func set_health(amount: int) -> void:
    _health = amount

func set_defense(amount: int) -> void:
    _defense = amount

func set_speed(amount: int) -> void:
    _speed = amount

func heal(amount: int) -> void:
    _health = min(_max_health,_health+amount)

func take_damage(amount: int) -> void:
    _health -= max(0,amount-get_defense())
    if (_health <= 0):
        dead()

func dead() -> void:
    push_error(name + " is missing a dead() method")

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
