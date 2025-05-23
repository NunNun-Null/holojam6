extends PlayerFighter

var valid_moves: Array[Move]

@export var speed: int = 0
@export var health: int = 1
@export var max_health: int = 1
@export var defense: int = 0

@export var special_point: int = 0
@export var given_name: String = ""


func _ready() -> void:
	set_health(health)
	set_max_health(max_health)
	set_speed(speed)
	set_defense(defense)
	set_special(special_point)
	set_given_name(given_name)

	visible = false
	for move in moves.get_children():
		if (move is Move):
			valid_moves.append(move)

func start_turn() -> void:
	add_special(1)
	var attack: Move = valid_moves.pick_random()
	attack.move()
	await get_tree().create_timer(2).timeout
	print(get_given_name() + " used " + str(attack.name))
	SignalManager.on_move_completed.emit()

func dead() -> void:
	super()

