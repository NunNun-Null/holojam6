extends Node

func convert_to_enemies(list: Array) -> Array:
	var array: Array
	for nodes in list:
		var node = nodes.instantiate()
		get_tree().root.add_child(node)
		array.append(node)
	return array

func convert_to_players(list: Array) -> Array:
	var array: Array
	for nodes in list:
		var node = nodes.instantiate()
		get_tree().root.add_child.call_deferred(node)
		array.append(node)
	return array

func sort(list: Array) -> Array:
	var array: Array = list
	var swapped
	for i in range(array.size()):
		swapped = false
		for j in range(array.size()-i-1):
			if (compare_fighters(array[j],array[j+1]) == 1):
				var temp = array[j]
				array[j] = array[j+1]
				array[j+1] = temp
				swapped = true
		if (!swapped):
			return array
	return array

# 1: fighter1 > fighter2
# -1: figher1 < fighter2
# 0: fighter1 == fighter2
func compare_fighters(fighter1, fighter2) -> int:
	if (fighter1.get_speed() > fighter2.get_speed()):
		return 1
	elif (fighter1.get_speed() < fighter2.get_speed()):
		return -1
	return 0
