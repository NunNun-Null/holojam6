extends Room

@export var required_battle: String

func reset_room() -> void:
	return

func _ready() -> void:
	visible = false
	if (!SceneManager.battle_progression.has(required_battle)):
		return
	if (SceneManager.battle_progression.get(required_battle)):
		$"doors/Core Emotion/Teleport Component".can_teleport = true