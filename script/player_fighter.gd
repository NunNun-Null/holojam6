extends Fighter
class_name PlayerFighter

func start_turn() -> void: 
    push_error(name + " is missing a start_turn() method")
    SignalManager.on_move_completed.emit()

func dead() -> void:
    push_error(name + " is missing a dead() method")
