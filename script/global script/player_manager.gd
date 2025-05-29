extends Node

var has_init: bool = false

var elizabeth: PackedScene = preload("res://entities/player/player_team/elizabeth.tscn")
var _squad: Array[PackedScene]

var room: String = "Bedroom"

var _position: Vector3

func _ready() -> void:
	SignalManager.on_switch_to_battle.connect(set_last_position)
	SignalManager.on_switch_to_map.connect(get_last_position)
	SignalManager.on_map_ready.connect(set_last_room_visible)

func start_up() -> void:
	print("starting up")
	_squad.append(load("res://entities/player/player_team/elizabeth.tscn"))
	_squad.append(load("res://entities/player/player_team/cecilia.tscn"))
	_squad.append(load("res://entities/player/player_team/raora.tscn"))
	_squad.append(load("res://entities/player/player_team/gigi.tscn"))
	reset_team()
	has_init = true

func reset_team_status() -> void:
	for player in BattleManager._players:
		player._health = player._max_health
		player.special = player.starting_special
		player.reset_effects()
		
func reset_team() -> void:
	var players: Array = UtilitiesManager.convert_to_players(_squad)
	BattleManager.create_players(players)

func set_last_position() -> void:
	_position = GlobalManager.get_player().global_position

func get_last_position() -> void:
	GlobalManager.get_player().global_position = _position

func set_last_room_visible():
	var map_node: Node3D
	for nodes in get_tree().root.get_children():
		if (nodes.name.match("Map")):
			map_node = nodes

	var room_node: Node3D = map_node.find_child(room)
	room_node.visible = true
