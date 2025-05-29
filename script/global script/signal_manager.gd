extends Node

signal on_room_change(origin, destination, location: Node3D) #Signal when the player enters a room

signal on_move_completed() #Signal when a fighter completes their turn

signal on_switch_to_map() #Signal after scene changes to map

signal on_switch_to_battle() #Signal before scene changes to battle

signal on_entered_battle(node: Node3D) #Signal when before scene switches to battle scene (enemies are already created)

signal on_player_defeated(Fighter) #Signal on a player squad member dead

signal on_player_lost() #Signal when a player loses the battle

signal on_player_turn(fighter) #Signal when it's a player member's turn

signal on_enemy_turn(fighter) #Signal when it's an enemy turn

signal on_player_select(fighter) #Signal on combat screen, player is highlighted

signal on_player_unselect(fighter) #Signal on combat screen, player is unhighlighted

signal on_player_stat_updated(Fighter) #Signal on any buff/debuff/damage/heal

signal on_enemy_defeated() #Signal when an enemy is defeated

signal on_order_updated(list: Array) #Signal when order is updated

signal on_dialogue_pushed() #Signal when dialogue pushed through
#For moves, it must be called at the end (take_damage() from fighter class has it called already)

signal on_first_enemy_fighter_ready() #Signal ready for the first enemy fighter 

signal on_player_turn_stunned() #Signal when a player starts their turn with stun effect (turn skipped)

signal on_victory() #Signal when player wins battle

signal on_map_ready() #Signal when map is init

signal on_dialogue_finished() #Signal when dialogue is finished

signal on_new_round() #Signal when a new round begins

signal on_enemy_added() #Signal when enemy is added
