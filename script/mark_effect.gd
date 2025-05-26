extends Effect

func _ready() -> void:
	given_effect_name = "marked"
	
func effect() -> void:
	get_target().set_mark(true)

func reverse_effect() -> void:
	get_target().set_mark(false)
	queue_free()
