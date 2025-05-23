extends Node
class_name Move

@export var _strategies: Array[Strategy]

func _ready() -> void:
	if (_strategies.is_empty()):
		push_error("There are no strategies for the move " + name + " for " + get_parent().get_parent().name)

func get_strategy(index: int) -> Strategy:
	return _strategies.get(index)

func get_random_strategy() -> Strategy:
	return _strategies.pick_random()

func move() -> void:
	push_error(name + " is missing a move() method")

func accuracy_test(amount: int) -> bool:
	randomize()
	var rand: int = randi_range(1,100)
	if (amount >= rand):
		return true
	return false