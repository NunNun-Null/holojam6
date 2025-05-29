extends Move

@export var text: String

func move() -> void:
	DialogueManager.add_battle_dialogue(text)
	SignalManager.on_dialogue_pushed.emit()
