extends Node

var dialogue_list: Array[String]

func add_battle_dialogue(content: String) -> void:
	dialogue_list.append(content)

#For Ingame Battle Dialogue

func get_dialogue_list() -> Array[String]:
	return dialogue_list
	
func clear_dialogue() -> void:
	dialogue_list.clear()

#For Map Dialogue

func add_dialogue_list(content: Array[String]) -> void:
	dialogue_list.append_array(content)
	dialogue_list.reverse()

func pop_dialogue_portion() -> Array[String]:
	var array: Array[String]
	if (dialogue_list.is_empty()):
		SignalManager.on_dialogue_finished.emit()
		return []
	print("current_list: " + str(dialogue_list))
	for i in range(dialogue_list.size()):
		print("top list: "+dialogue_list.get(dialogue_list.size()-1)) 
		if (dialogue_list.get(dialogue_list.size()-1) == "#"):
			dialogue_list.pop_back()
			print("found: #. returning")
			print("\n")
			return array
		print("adding " + dialogue_list.get(dialogue_list.size()-1))
		array.append(dialogue_list.pop_back())
	print("\n")
	return array


#Utilities

func is_empty() -> bool:
	return dialogue_list.is_empty()
