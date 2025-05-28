extends Fighter
class_name PlayerFighter

var special: int = 0
var is_dead: bool = false

func set_dead(value: bool) -> void:
	is_dead = value

func get_dead() -> bool:
	return is_dead


func get_special() -> int:
	return special

func set_special(amount: int) -> void:
	special = amount
	SignalManager.on_player_stat_updated.emit(self)

func add_special(amount: int,value:bool=false) -> void:
	special += amount
	SignalManager.on_player_stat_updated.emit(self)
	if (value and amount > 0):
		DialogueManager.add_battle_dialogue(get_given_name() + " gained " + str(amount) + " SP")
		SignalManager.on_dialogue_pushed.emit()


func remove_special(amount: int) -> void:
	special -= amount
	SignalManager.on_player_stat_updated.emit(self)

func start_turn() -> void: 
	return

func take_damage(amount: int, pierce: int = 0) -> void:
	super(amount,pierce)
	SignalManager.on_player_stat_updated.emit(self)
	
func dead() -> void:
	for eff in effects:
		eff.reverse_effect()
	DialogueManager.add_battle_dialogue(get_given_name() + " is down")
	print(get_given_name() + " is down")
	SignalManager.on_player_defeated.emit(self)
	SignalManager.on_dialogue_pushed.emit()
	set_dead(true)
