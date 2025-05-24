extends Fighter
class_name EnemyFighter

@export var selected_box: CSGBox3D

func _ready() -> void:
    if (selected_box):
        selected_box.visible = false
        
func start_turn() -> void: 
    push_error(name + " is missing a start_turn() method")

func dead() -> void:
    DialogueManager.add_battle_dialogue(get_given_name() + " is defeated")
    print(get_given_name() + " is defeated")
    SignalManager.on_dialogue_pushed.emit()


func set_selected(value: bool) -> void:
    if (!selected_box):
        return
    selected_box.visible = value 