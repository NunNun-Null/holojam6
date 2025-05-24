extends Node

signal on_room_change(origin: Room, destination: Room, location: Node3D) #Signal when the player enters a room

signal on_move_completed() #Signal when a fighter completes their turn

signal on_switch_to_map() #Signal after scene changes to map

signal on_switch_to_battle() #Signal before scene changes to battle

signal on_entered_battle(node: Node3D) #Signal when before scene switches to battle scene (enemies are already created)

signal on_player_defeated(Fighter: PlayerFighter) #Signal on a player squad member dead

signal on_player_turn(fighter: PlayerFighter) #Signal when it's a player member's turn

signal on_player_revived(Fighter: PlayerFighter) #Signal on a player squad member revived (MUST IMPLEMENT)

signal on_player_select(fighter: PlayerFighter) #Signal on combat screen, player is highlighted

signal on_player_unselect(fighter: PlayerFighter) #Signal on combat screen, player is unhighlighted

signal on_player_stat_updated(Fighter: PlayerFighter) #Signal on any buff/debuff/damage/heal

signal on_enemy_defeated() #Signal when an enemy is defeated

signal on_order_updated(list: Array[Fighter]) #Signal when order is updated
