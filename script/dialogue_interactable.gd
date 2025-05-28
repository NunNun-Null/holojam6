extends Area3D

@export var content: Array[String]

var can_talk: bool = false
var available: bool = true

@export var one_time: bool = false
@export var move_into: bool = false
func _ready() -> void:
	SignalManager.on_dialogue_finished.connect(reset_available)

func _on_body_entered(body:Node3D) -> void:
	if (body is Player):
		can_talk = true

func _on_body_exited(body:Node3D) -> void:
	if (body is Player):
		can_talk = false

func _process(_delta: float) -> void:
	if ((Input.is_action_just_pressed("interact") or move_into) and can_talk and available):
		print("pushing dialogue")
		available = false
		DialogueManager.add_dialogue_list(content)
		SignalManager.on_dialogue_pushed.emit()


func reset_available() -> void:
	if (move_into or one_time):
		queue_free()
	await get_tree().create_timer(2).timeout
	available = true
