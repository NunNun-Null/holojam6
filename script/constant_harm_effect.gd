extends Effect

func _ready() -> void:
	given_effect_name = "poison"

func reapply(fighter: Fighter) -> void:
	fighter.remove_health(strength)

func reverse_effect() -> void:
	# DialogueManager.add_battle_dialogue()
	queue_free()
