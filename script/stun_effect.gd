extends Effect

func _ready() -> void:
	given_effect_name = "stun"
func effect() -> void:
	get_target().set_stun(true)

func reverse_effect() -> void:
	get_target().set_stun(false)
	queue_free()