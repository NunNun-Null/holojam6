extends Node
class_name Effect

var duration: int = 1

var strength: int = 1

var active: bool = false

var target: Fighter

var host: Fighter

var is_debuff: bool

var given_effect_name: String

func apply_effect(fighter: Fighter) -> void:
	reapply(fighter)
	lower_duration()


func reapply(fighter: Fighter) -> void:
	return

func effect() -> void:
	return

func set_host(fighter: Fighter) -> void:
	host = fighter

func set_target(fighter: Fighter) -> void:
	target = fighter

func get_host() -> Fighter:
	return host

func reverse_effect() -> void:
	push_error(name + " is missing reverse_effect() method")

func set_duration(amount: int) -> void:
	duration = amount

func set_strength(amount: int) -> void:
	strength = amount
	
func get_target() -> Fighter:
	return target

func lower_duration() -> void:
	duration -= 1
	if (duration <= 0):
		reverse_effect()
		print(name + " has wore off")
		call_deferred("queue_free")
