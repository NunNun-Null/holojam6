extends Node

signal on_room_change(origin: Room, destination: Room, location: Node3D) #Signal when the player enters a room

signal on_move_completed() #Signal when a fighter completes their turn

signal on_switch_to_map() #Signal after scene changes to map

signal on_switch_to_battle() #Signal before scene changes to battle

signal on_entered_battle(node: Node3D) #Signal when before scene switches to battle scene (enemies are already created)

signal on_enemy_defeated() #Signal when an enemy is defeated