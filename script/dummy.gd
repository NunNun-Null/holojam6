extends EnemyFighter

var valid_moves: Array[Move]


@export var speed: int = 0
@export var health: int = 1
@export var max_health: int = 1
@export var defense: int = 0
@export var given_name: String = ""

func _ready() -> void:
	set_max_health(max_health)
	set_health(health)
	set_speed(speed)
	set_defense(defense)
	set_given_name(given_name)
	for move in moves.get_children():
		if (move is Move):
			valid_moves.append(move)

func start_turn() -> void:
	if (BattleManager.turn == 1):
		await SignalManager.on_enemy_turn
	if (get_stun()):
		DialogueManager.add_battle_dialogue("> " + get_given_name() + " is stunned")
		SignalManager.on_dialogue_pushed.emit()
		return
	SignalManager.on_enemy_turn.emit()
	var attack: Move = valid_moves.pick_random()
	attack.move()

func dead() -> void:
	super()
	BattleManager.remove_enemy_fighter(self)
	SignalManager.on_enemy_defeated.emit()
	queue_free()