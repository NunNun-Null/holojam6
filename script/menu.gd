extends Control

var current: int = 0


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://area/map.tscn")

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("move_up")):
		if (current > 0):
			current -= 1
			update()
	elif (Input.is_action_just_pressed("move_down")):
		if (current < 1):
			current += 1
			update()
	elif (Input.is_action_just_pressed("interact")):
		if (current == 0):
			get_tree().change_scene_to_file("res://area/map.tscn")
		elif (current == 1):
			get_tree().change_scene_to_file("res://ui/settings.tscn")

func update() -> void:
	$Panel/RichTextLabel.text = "[b][font_size=40]Elizabeth's Dilemma[/font_size][/b]" + "\n\n"
	if (current == 0):
		$Panel/RichTextLabel.text += "> Start"
	else:
		$Panel/RichTextLabel.text += "Start"
	$Panel/RichTextLabel.text += "\n"
	
	if (current == 1):
		$Panel/RichTextLabel.text += "> Settings"
	else:
		$Panel/RichTextLabel.text += "Settings"
	
	
