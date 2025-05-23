extends Node

var _elizabeth: PackedScene = load("res://entities/player/player_team/elizabeth.tscn")
var _cecila: PackedScene = load("res://entities/player/player_team/cecilia.tscn")
var _raora: PackedScene = load("res://entities/player/player_team/raora.tscn")
var _gigi: PackedScene = load("res://entities/player/player_team/gigi.tscn")

var _squad: Array[PackedScene]

var _position: Vector3

func _ready() -> void:
	_squad.append(_elizabeth)
	_squad.append(_cecila)
	_squad.append(_raora)
	_squad.append(_gigi)
	reset_team()
	SignalManager.on_switch_to_battle.connect(set_last_position)
	SignalManager.on_switch_to_map.connect(get_last_position)

func reset_team() -> void:
	var players: Array[PlayerFighter] = UtilitiesManager.convert_to_players(_squad)
	BattleManager.create_players(players)

func set_last_position() -> void:
	_position = GlobalManager.get_player().global_position

func get_last_position() -> void:
	GlobalManager.get_player().global_position = _position
