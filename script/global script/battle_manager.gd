extends Node3D

var _players: Array
var _enemies: Array

var _round: Array

var current_round: int = 1
var turn: int = 1
func get_current_round() -> int:
	return current_round
	
func _ready() -> void:
	
	SignalManager.on_move_completed.connect(end_turn)
	SignalManager.on_victory.connect(remove_all_fighter_effects)


func add_fighter(fighter) -> void:
	_enemies.append(fighter)
	SignalManager.on_enemy_added.emit()
	
func create_enemies(list: Array) -> void:
	_enemies.clear()
	_enemies.append_array(list)

func create_players(list: Array) -> void:
	_players.clear()
	_players.append_array(list)

func remove_player_fighter(fighter):
	var index: int
	index = _round.find(fighter)
	_round.remove_at(index)

func switch_to_battle() -> void:
	get_tree().change_scene_to_file("res://area/battle.tscn")
	SignalManager.on_switch_to_battle.emit()

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
	SignalManager.on_order_updated.emit(_round)


func get_enemy_fighter(index: int):
	return _enemies[index]

func get_enemies_size() -> int:
	return _enemies.size()

func get_player_fighter(index: int):
	return _players[index]

func get_players_size() -> int:
	return _players.size()


func start_battle() -> void:
	print("Starting Battle")
	current_round = 1
	turn = 0
	_round.clear()
	establish_order()
	start_turn()
	SignalManager.on_order_updated.emit(_round)

func get_top_fighter():
	return _round[_round.size()-1]

func pop_fighter() -> void:
	_round.remove_at(_round.size()-1)
	if (_round.is_empty()):
		establish_order()
		current_round+=1
		SignalManager.on_new_round.emit()

func remove_enemy_fighter(fighter):
	var index: int
	index = _enemies.find(fighter)
	_enemies.remove_at(index)

	index = _round.find(fighter)
	_round.remove_at(index)

	SignalManager.on_order_updated.emit(_round)

func remove_all_fighter_effects() -> void:
	for ally in _players:
		for node in ally.effects.get_children():
			node.reverse_effect()

func lose_condition() -> bool:
	var down: int = 0
	for player in BattleManager._players:
		if (player.get_dead()):
			down+=1
	if(down >= 4):
		return true
	return false

func remove_enemies() -> void:
	for enemy in _enemies:
		enemy.queue_free()
	_enemies.clear()
	
func start_turn() -> void:
	turn+=1
	if (lose_condition()):
		print("LOSE")
		_round.clear()
		SignalManager.on_player_lost.emit()
		remove_enemies()
		current_round = 1
		turn = 1
		call_deferred("switch_to_map")
		
		return

	if (_enemies.is_empty()):
		print("WIN")
		_round.clear()
		SignalManager.on_victory.emit()
		current_round = 1
		turn = 1
		call_deferred("switch_to_map")
		return
	
	var fighter = get_top_fighter()
	print("current turn: " + fighter.get_given_name())
	if (!fighter):
		end_turn()
		return
	
	fighter.apply_effects(fighter)

	if (!fighter):
		end_turn()
		return
	
	if (fighter.has_method("get_dead")):
		if (fighter.get_dead()):
			end_turn()
			return

	fighter.start_turn()

func end_turn() -> void:
	pop_fighter()
	SignalManager.on_order_updated.emit(_round)
	start_turn()
