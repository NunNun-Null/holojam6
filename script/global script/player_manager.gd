extends Node

var elizabeth: PackedScene = load("res://entities/player/player_team/elizabeth.tscn")
var cecila: PackedScene 
var raora: PackedScene
var gigi: PackedScene

var squad: Array[PackedScene]

func _ready() -> void:
	squad.append(elizabeth)
	# squad.append(cecila)
	# squad.append(raora)
	# squad.append(gigi)
	reset_team()

func reset_team() -> void:
	var players: Array[PlayerFighter] = UtilitiesManager.convert_to_players(squad)
	BattleManager.create_players(players)
