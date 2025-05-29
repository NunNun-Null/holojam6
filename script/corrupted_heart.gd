extends EnemyFighter

var valid_moves: Array[Move]

@export var speed: int = 0
@export var health: int = 1
@export var max_health: int = 1
@export var defense: int = 0
@export var given_name: String = ""

var current: int = 0
var turns_without_orb: int = 3
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
	
	var attack: Move = moves.get_child(2)
	var exists: bool = false
	current = current % 5
	
	for enemy in BattleManager._enemies:
		if (enemy.get_given_name() == "Orb of Life"):
			exists = true
			break
	
	if (turns_without_orb >= 3 and !exists):
		attack = moves.get_child(0)
		turns_without_orb = 0
	else:
		if (!exists):
			turns_without_orb += 1
		if (current == 1 and BattleManager._enemies.size() < 3):
			attack = moves.get_child(1)
		elif (current == 3):
			attack = moves.get_child(3)
		current += 1
	attack.move()
	return

func dead() -> void:
	super()
	BattleManager.remove_enemy_fighter(self)
	SignalManager.on_enemy_defeated.emit()
	queue_free()
