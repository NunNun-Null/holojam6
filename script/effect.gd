extends Node
class_name Effect

var pernament: bool = false

func set_perm(value: bool) -> void:
    pernament = value

func get_perm() -> bool:
    return pernament
    
func apply_effect() -> void:
    push_error(name + " is missing an apply_effect()")