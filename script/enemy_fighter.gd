extends Fighter
class_name EnemyFighter

@export var selected_box: CSGBox3D

func _ready() -> void:
	if (selected_box):
		selected_box.visible = false
		
func start_turn() -> void: 
	SignalManager.on_enemy_turn.emit()
	super()


func dead() -> void:
	for eff in effects.get_children():
		eff.reverse_effect()
	DialogueManager.add_battle_dialogue(get_given_name() + " is defeated")
	print(get_given_name() + " is defeated")
	SignalManager.on_dialogue_pushed.emit()


func set_selected(value: bool) -> void:
	if (!selected_box):
		return
	selected_box.visible = value 
