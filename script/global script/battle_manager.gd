extends Node3D

var BATTLE = preload("res://area/battle.tscn")

var _battle: Node3D
var _players: Array[PlayerFighter]
var _enemies: Array[EnemyFighter]

var _round: Array[Fighter]

	
func _ready() -> void:
	SignalManager.on_move_completed.connect(end_turn)

func get_battle_map() -> Node3D:
	return _battle

func create_enemies(list: Array[EnemyFighter]) -> void:
	_enemies.clear()
	_enemies.append_array(list)

func create_players(list: Array[PlayerFighter]) -> void:
	_players.append_array(list)

func remove_player_fighter(fighter: PlayerFighter):
	var index: int
	index = _round.find(fighter)
	_round.remove_at(index)

func switch_to_battle() -> void:
	SignalManager.on_switch_to_battle.emit()
	get_tree().change_scene_to_file("res://area/battle.tscn")

func switch_to_map() -> void:
	get_tree().change_scene_to_file("res://area/map.tscn")
	SignalManager.on_switch_to_map.emit()

func establish_order() -> void:
	for player in _players:
		if !player.get_dead():
			_round.append(player)
	_round.append_array(_enemies)
	_round = UtilitiesManager.sort(_round)
	print("Round Order" + str(_round))


func get_enemy_fighter(index: int) -> EnemyFighter:
	return _enemies.get(index)

func get_enemies_size() -> int:
	return _enemies.size()

func get_player_fighter(index: int) -> PlayerFighter:
	return _players.get(index)

func get_players_size() -> int:
	return _players.size()


func start_battle() -> void:
	print("Starting Battle")
	_round.clear()
	establish_order()
	start_turn()

func get_top_fighter() -> Fighter:
	return _round.get(_round.size()-1)

func pop_fighter() -> void:
	_round.remove_at(_round.size()-1)
	if (_round.is_empty()):
		establish_order()

func remove_enemy_fighter(fighter: EnemyFighter):
	var index: int
	index = _enemies.find(fighter)
	_enemies.remove_at(index)

	index = _round.find(fighter)
	_round.remove_at(index)



func start_turn() -> void:
	if (_players.is_empty()):
		print("LOSE")
		_round.clear()
		call_deferred("switch_to_map")
		
		return

	if (_enemies.is_empty()):
		print("WIN")
		_round.clear()
		call_deferred("switch_to_map")
		return
	
	var fighter: Fighter = get_top_fighter()
	print("current turn: " + fighter.get_given_name())
	if (!fighter):
		start_turn()
		return
	
	fighter.apply_effects(fighter)

	if (!fighter):
		start_turn()
		return
	
	if (!fighter.get_stun()):
		fighter.start_turn()
	else:
		print(fighter.get_given_name() + " is stunned")
	print("\n")
	if (fighter.get_stun()):
		start_turn()

func end_turn() -> void:
	pop_fighter()
	start_turn()