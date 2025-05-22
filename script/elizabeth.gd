extends PlayerFighter

var valid_moves: Array[Move]

func _ready() -> void:
	visible = false
	for move in moves.get_children():
		if (move is Move):
			valid_moves.append(move)

func start_turn() -> void:
	var attack: Move = valid_moves.pick_random()
	attack.move()
	await get_tree().create_timer(2).timeout
	print(name + " used " + str(attack.name))
	SignalManager.on_move_completed.emit()
