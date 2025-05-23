extends Node
class_name Effect

var duration: int = 1

var strength: int = 1

var active: bool = false

var target: Fighter

func apply_effect(fighter: Fighter) -> void:
    if (!active):
        active = true
        target = fighter
        effect()
    print("applying " + name)
    lower_duration()

func effect() -> void:
    push_error(name + " is missing effect() method")

func reverse_effect() -> void:
    push_error(name + " is missing reverse_effect() method")

func set_duration(amount: int) -> void:
    duration = amount

func set_strength(amount: int) -> void:
    strength = amount
    
func get_fighter() -> Fighter:
    return target

func lower_duration() -> void:
    duration -= 1
    if (duration <= 0):
        reverse_effect()
        print(name + " has wore off")
        call_deferred("queue_free")
