extends Control

var can_continue = false

func _ready() -> void:
    SignalManager.on_dialogue_pushed.connect(dialogue)

func dialogue() -> void:
    visible = true
    $PanelContainer/Text.text = ""
    $PanelContainer/Text.visible_ratio = 0

    var contents: Array[String] = DialogueManager.pop_dialogue_portion()
    if (contents.is_empty()):
        end_dialogue()
        return

    for content in contents:
        $PanelContainer/Text.text += content + "\n"
    var tween: Tween = create_tween()
    tween.tween_property($"PanelContainer/Text","visible_ratio",1,2)
    await tween.finished
    can_continue = true

func _process(_delta: float) -> void:
    if (can_continue and Input.is_action_just_pressed("interact")):
        dialogue()

func end_dialogue() -> void:
    visible = false
    can_continue = false
    SignalManager.on_dialogue_finished.emit()