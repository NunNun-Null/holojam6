extends Fighter
class_name EnemyFighter

@export var selected_box: CSGBox3D

func _ready() -> void:
    if (selected_box):
        selected_box.visible = false
        
func start_turn() -> void: 
    push_error(name + " is missing a start_turn() method")
    SignalManager.on_move_completed.emit()

func dead() -> void:
    push_error(name + " is missing a dead() method")

func set_selected(value: bool) -> void:
    if (!selected_box):
        return
    selected_box.visible = value 