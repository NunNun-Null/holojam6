extends EnemyFighter

var valid_moves: Array[Move]

func _ready() -> void:
	for move in moves.get_children():
		if (move is Move):
			valid_moves.append(move)

func start_turn() -> void:
	var attack: Move = valid_moves.pick_random()
	attack.move()
	await get_tree().create_timer(2).timeout
	turn_complete.emit()
