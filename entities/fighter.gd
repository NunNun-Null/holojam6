extends Node3D
class_name Fighter

@export var moves: Node
@export var effects: Node


var _given_name: String
var _speed: int
var _health: int
var _defense: int

var _defended: Fighter

var _max_health: int 

var _adjusted_speed: int
var _adjusted_defense: int

var _is_stunned: bool = false

var _is_marked: bool = false

var _damage_multiplier: int = 0

func set_defended(target: Fighter) -> void:
    _defended = target

func reset_defended() -> void:
    _defended = null

func is_defended() -> bool:
    if (_defended):
        return true
    return false

func get_defended() -> Fighter:
    return _defended

func set_given_name(text: String) -> void:
    _given_name = text

func get_given_name() -> String:
    return _given_name
func add_damage_multipler(amount: int) -> void:
    _damage_multiplier += amount

func remove_damage_multipler(amount: int) -> void:
    _damage_multiplier -= amount

func get_mark() -> bool:
    return _is_marked

func set_mark(value: bool) -> void:
    _is_marked = value


func get_stun() -> bool:
    return _is_stunned

func set_stun(value: bool) -> void:
    _is_stunned = value

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

func add_effect(effect: Effect) -> void:
    effects.add_child(effect)

func take_damage(amount: int, pierce: int = 0) -> void:
    if (is_defended()):
        print(get_given_name() + " is defended by " + get_defended().get_given_name())
        _defended.take_damage(amount,pierce)
        return
    var pierce_amount: int = max(0,get_defense()-pierce)
    var damage: int = max(0,amount-pierce_amount)
    if (damage <= 0):
        print(get_given_name() + " absorbed the damage")
        return
    print(get_given_name() + " took " + str(damage) + " damage")
    _health -= damage + _damage_multiplier
    if (_health <= 0):
        dead()

func dead() -> void:
    push_error(name + " is missing a dead() method")

func start_turn() -> void:
    push_error(name + " is missing a start_turn() method")
    SignalManager.on_move_completed.emit()

func apply_effects(fighter: Fighter) -> void:
    for effect in effects.get_children():
        if (effect is Effect):
            effect.apply_effect(fighter)

func reset_effects() -> void:
    for effect in effects.get_children():
        if (effect is Effect):
            if (!effect.get_perm()):
                effect.apply_effect()
