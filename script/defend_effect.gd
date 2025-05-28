extends Effect

func _ready() -> void:
	given_effect_name = "defended"
func effect() -> void:
	if (!host):
		push_error(name + " is missing a guard fighter")
		return
	get_target().set_defended(host)
	host.set_defender(get_target())

func reverse_effect() -> void:
	get_target().reset_defended()
	host.reset_defender()
	queue_free()
	