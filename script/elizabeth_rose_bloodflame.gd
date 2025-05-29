extends EnemyFighter

var valid_moves: Array[Move]

@export var speed: int = 0
@export var health: int = 1
@export var max_health: int = 1
@export var defense: int = 0
@export var given_name: String = ""

var current: int = 0
var phase: int = 1
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
	
	if (get_health() <= 75 and phase == 1):
		attack = moves.get_child(6)
		switch_to_phase_2()
		attack.move()
		return
		
	
	current = current % 6
	
	attack = moves.get_child(current)
	
	if (current == 3 and BattleManager._enemies.size() > 2):
		attack = moves.get_child(2)
	
	current += 1
	attack.move()

func switch_to_phase_2() -> void:
	$"Phase 1".visible = false
	$"Phase 2".visible = true
	add_adjusted_speed(3)
	add_bonus_accuracy(20)
	add_bonus_damage(2)
	add_adjusted_defense(1)
	_health += 10
	set_given_name("Justitia")
	phase = 2

func dead() -> void:
	super()
	BattleManager.remove_enemy_fighter(self)
	SignalManager.on_enemy_defeated.emit()
	queue_free()
