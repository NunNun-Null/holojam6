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


func add_special(amount: int) -> void:
	special += amount
	SignalManager.on_player_stat_updated.emit(self)


func remove_special(amount: int) -> bool:
	if (special < amount):
		return false
	special -= amount
	SignalManager.on_player_stat_updated.emit(self)
	return true

func start_turn() -> void: 
	push_error(name + " is missing a start_turn() method")
	SignalManager.on_move_completed.emit()

func take_damage(amount: int, pierce: int = 0) -> void:
	super(amount,pierce)
	SignalManager.on_player_stat_updated.emit(self)
	
func dead() -> void:
	SignalManager.on_player_defeated.emit(self)
	set_dead(true)
