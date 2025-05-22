extends Node

signal on_room_change(origin: Room, destination: Room, location: Node3D) #Signal when the player enters a room

signal on_battle_won() #Signal when player wins a battle

signal on_move_completed()

signal on_switch_to_map()

signal on_switch_to_battle()

signal on_enemy_defeated()