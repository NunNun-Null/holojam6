extends Node
class_name Move

@export_category("For Enemies")
@export var _strategies: Array[Strategy]

@export_category("For Players")
@export_multiline var description: String = ""
@export var intended_for_allies: bool = false
@export var sp_cost: int = 0

var _target: Fighter

func _ready() -> void:
	if (_strategies.is_empty() and get_parent().get_parent() is not PlayerFighter ):
		push_error("There are no strategies for the move " + name + " for " + get_parent().get_parent().get_given_name())

func get_strategy(index: int) -> Strategy:
	return _strategies.get(index)

func has_strategy() -> bool:
	return !_strategies.is_empty()

func is_for_allies() -> bool:
	return intended_for_allies 

func get_random_strategy() -> Strategy:
	return _strategies.pick_random()

func set_target(fighter: Fighter) -> void:
	_target = fighter

func get_target() -> Fighter:
	return _target

func get_desc() -> String:
	if (description == ""):
		push_warning("Description is missing for " + name)
	return description

func move() -> void:
	push_error(name + " is missing a move() method")

func accuracy_test(amount: int) -> bool:
	if (!get_target().get_mark()):
		return true
	randomize()
	var rand: int = randi_range(1,100)
	if (amount >= rand):
		return true
	return false

func has_enough_sp(sp: int) -> bool:
	if (sp >= sp_cost):
		return true
	return false

func get_cost() -> int:
	return sp_cost