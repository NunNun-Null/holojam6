extends Node

func convert_to_enemies(list: Array[PackedScene]) -> Array[EnemyFighter]:
	var array: Array[EnemyFighter]
	for nodes in list:
		var node = nodes.instantiate()
		get_tree().root.add_child(node)
		array.append(node)
	return array

func convert_to_players(list: Array[PackedScene]) -> Array[PlayerFighter]:
	var array: Array[PlayerFighter]
	for nodes in list:
		var node = nodes.instantiate()
		get_tree().root.add_child.call_deferred(node)
		array.append(node)
	return array

func sort(list: Array[Fighter]) -> Array[Fighter]:
	var array: Array[Fighter] = list
	var swapped
	for i in range(array.size()):
		swapped = false
		for j in range(array.size()-i-1):
			if (compare_fighters(array.get(j),array.get(j+1)) == 1):
				var temp: Fighter = array.get(j)
				array.set(j,array.get(j+1))
				array.set(j+1,temp)
				swapped = true
		if (!swapped):
			return array
	return array

# 1: fighter1 > fighter2
# -1: figher1 < fighter2
# 0: fighter1 == fighter2
func compare_fighters(fighter1: Fighter, fighter2: Fighter) -> int:
	if (fighter1.get_speed() > fighter2.get_speed()):
		return 1
	elif (fighter1.get_speed() < fighter2.get_speed()):
		return -1
	return 0

