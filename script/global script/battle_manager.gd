extends Node3D

var MAX_SIZE: int = 4

var _enemies: Array[EnemyFighter]
var _players: Array[PlayerFighter]
var _round_turn: Array[Fighter]

func create_enemies(list: Array[EnemyFighter]) -> void:
    _enemies.clear()
    _enemies.append_array(list)

func create_players(list: Array[PlayerFighter]) -> void:
    _enemies.clear()
    _enemies.append_array(list)

func enemies_is_full() -> bool:
    if (_enemies.size() >= MAX_SIZE):
        return true
    return false

func players_is_full() -> bool:
    if (_players.size() >= MAX_SIZE):
        return true
    return false

func add_enemy(enemy: EnemyFighter) -> void:
    _enemies.append(enemy)

func establish_order() -> void:
    _round_turn.append_array(_enemies)
    _round_turn.append_array(_players)
    _round_turn = UtilitiesManager.sort(_round_turn)

func get_next_fighter() -> Fighter:
    _round_turn.remove_at(_round_turn.size()-1)
    if (_round_turn.is_empty()):
        establish_order()
    return _round_turn.get(_round_turn.size()-1)
    

func remove_fighter(fighter: Fighter) -> void:
    _round_turn.remove_at(_round_turn.find(fighter))
    if (fighter is PlayerFighter):
        _players.remove_at(_players.find(fighter))
        return
    _enemies.remove_at(_enemies.find(fighter))

func get_players_size() -> int:
    return _players.size()

func get_enemies_size() -> int:
    return _enemies.size()

func get_player_fighter(index: int) -> PlayerFighter:
    return _players.get(index)

func get_enemy_fighter(index: int) -> EnemyFighter:
    return _enemies.get(index)

func start_round() -> void:
    establish_order()
    cycle_round()

func cycle_round() -> void:
    if (_players.is_empty()):
        return
    if (_enemies.is_empty()):
        for player in _players:
            player.reset_effects()
            get_tree().change_scene_to_file("res://area/map.tscn")
            SignalManager.on_battle_won.emit()

    var fighter: Fighter = get_next_fighter()
    fighter.apply_effects()
    if (!fighter):
        cycle_round()
        return

    fighter.start_turn()
    await fighter.turn_complete
    
    if (_enemies.is_empty()):
        return
    if (_players.is_empty()):
        return
    await get_tree().create_timer(3).timeout
    cycle_round()

