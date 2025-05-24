extends Node

var dialogue_list: Array[String]

func add_battle_dialogue(content: String) -> void:
	print("added to the queue: " + content)
	dialogue_list.append(content)

func get_next_dialogue() -> String:
	if (dialogue_list.is_empty()):
		return "#"
	return dialogue_list.get(0)

func get_dialogue_list() -> Array[String]:
	return dialogue_list
	
func clear_dialogue() -> void:
	dialogue_list.clear()

func pop_dialogue() -> void:
	dialogue_list.remove_at(dialogue_list.size()-1)
