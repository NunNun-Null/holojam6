extends EnemyFighter

var valid_moves: Array[Move]

@export var speed: int = 0
@export var health: int = 1
@export var max_health: int = 1
@export var defense: int = 0
@export var given_name: String = ""

var current: int = 0

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
	
	var attack: Move
	var exists: bool = false
	current = current % 6
	
	if (current == 0):
		for enemy in BattleManager._enemies:
			if (enemy.get_given_name() == "Orb of Life"):
				exists = true
		if (!exists):
			attack = moves.get_child(0)
	elif (current == 2):
		if (BattleManager.get_enemies_size() < 3):
			attack = moves.get_child(2)
	elif (current == 4):
		attack = moves.get_child(3)
	else:
		attack = moves.get_child(2)
	
	current += 1
	attack.move()
	return

func dead() -> void:
	super()
	BattleManager.remove_enemy_fighter(self)
	SignalManager.on_enemy_defeated.emit()
	queue_free()
