extends Node3D

var BATTLE = preload("res://area/battle.tscn")

var _battle: Node3D
var _players: Array[PlayerFighter]
var _enemies: Array[EnemyFighter]

var _round: Array[Fighter]

	
func _ready() -> void:
	_battle = BATTLE.instantiate()
	get_tree().root.add_child.call_deferred(_battle)
	SignalManager.on_move_completed.connect(start_turn)

func get_battle_map() -> Node3D:
	return _battle

func create_enemies(list: Array[EnemyFighter]) -> void:
	_enemies.clear()
	_enemies.append_array(list)

func create_players(list: Array[PlayerFighter]) -> void:
	_players.append_array(list)

func switch_to_battle() -> void:
	SignalManager.on_switch_to_battle.emit()
	get_tree().change_scene_to_file("res://area/battle.tscn")

func switch_to_map() -> void:
	get_tree().change_scene_to_file("res://area/map.tscn")
	SignalManager.on_switch_to_map.emit()

func establish_order() -> void:
	_round.append_array(_players)
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
	print("current turn: " + fighter.name)
	if (!fighter):
		start_turn()
		return
	
	fighter.apply_effects()

	if (!fighter):
		start_turn()
		return
	
	fighter.start_turn()
	print("\n")
	pop_fighter()
