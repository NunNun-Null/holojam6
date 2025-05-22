extends EnemyFighter

var valid_moves: Array[Move]


@export var speed: int = 0
@export var health: int = 1
@export var defense: int = 0

func _ready() -> void:
	set_health(health)
	set_speed(speed)
	set_defense(defense)
	for move in moves.get_children():
		if (move is Move):
			valid_moves.append(move)

func start_turn() -> void:
	var attack: Move = valid_moves.pick_random()
	attack.move()
	await get_tree().create_timer(2).timeout
	print(name + " used " + str(attack.name))
	SignalManager.on_move_completed.emit()
