extends Control

var current: int = 0

var listening: bool = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://area/map.tscn")
	update()

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("move_up") and !listening):
		if (current > 0):
			current -= 1
			update()
	elif (Input.is_action_just_pressed("move_down") and !listening):
		if (current < 7):
			current += 1
			update()
	elif (Input.is_action_just_pressed("back") and !listening):
		get_tree().change_scene_to_file("res://ui/menu.tscn")
		
	if (Input.is_action_just_pressed("interact") and !listening):
		if (current > 0):
			await get_tree().create_timer(0.1).timeout
			listening = true
			update()
	

func update() -> void:
	$Panel/RichTextLabel.text = "[font_size=40]Volume Settinsg[/font_size]" + "\n\n"
	
	if (current == 0):
		$Panel/RichTextLabel.text += "> Volume: 100%\n\n"
	else:
		$Panel/RichTextLabel.text += "Volume: 100%\n\n"
	
	$Panel/RichTextLabel.text += "[font_size=40]Keybinds[/font_size]\n\n"
	
	if (current == 1):
		if (listening):
			$Panel/RichTextLabel.text += "> Move Up/Navigate Up: ___\n"
		else:
			$Panel/RichTextLabel.text += "> Move Up/Navigate Up: " + get_key("move_up") + "\n"
	else:
		$Panel/RichTextLabel.text += "Move Up/Navigate Up: " + get_key("move_up") + "\n"
	
	if (current == 2):
		if (listening):
			$Panel/RichTextLabel.text += "> Move Down/Navigate Down: ___\n"
		else:
			$Panel/RichTextLabel.text += "> Move Down/Navigate Down: " + get_key("move_down") + "\n"
	else:
		$Panel/RichTextLabel.text += "Move Down/Navigate Down: " + get_key("move_down") + "\n"
	
	if (current == 3):
		if (listening):
			$Panel/RichTextLabel.text += "> Move Left: ___\n"
		else:
			$Panel/RichTextLabel.text += "> Move Left: " + get_key("move_left") + "\n"
	else:
		$Panel/RichTextLabel.text += "Move Left: " + get_key("move_left") + "\n"
	
	if (current == 4):
		if (listening):
			$Panel/RichTextLabel.text += "> Move Right: ___\n"
		else:
			$Panel/RichTextLabel.text += "> Move Right: " + get_key("move_right") + "\n"
	else:
		$Panel/RichTextLabel.text += "Move Right: " + get_key("move_right") + "\n"
	
	if (current == 5):
		if (listening):
			$Panel/RichTextLabel.text += "> Interact: ___\n"
		else:
			$Panel/RichTextLabel.text += "> Interact: " + get_key("interact") + "\n"
	else:
		$Panel/RichTextLabel.text += "Interact: " + get_key("interact") + "\n"
	
	if (current == 6):
		if (listening):
			$Panel/RichTextLabel.text += "> Go Back: ___\n"
		else:
			$Panel/RichTextLabel.text += "> Go Back: " + get_key("back") + "\n"
	else:
		$Panel/RichTextLabel.text += "Go Back: " + get_key("back") + "\n"
	
	if (current == 7):
		if (listening):
			$Panel/RichTextLabel.text += "> Go to Menu: ___\n"
		else:
			$Panel/RichTextLabel.text += "> Go to Menu: " + get_key("menu") + "\n"
	else:
		$Panel/RichTextLabel.text += "Go to Menu: " + get_key("menu") + "\n"

func _input(event: InputEvent) -> void:
	if (!listening):
		return
	if (event is InputEventKey):
		if (current == 1):
			rebind_key("move_up",event)
		elif (current == 2):
			rebind_key("move_down",event)
		elif (current == 3):
			rebind_key("move_left",event)
		elif (current == 4):
			rebind_key("move_right",event)
		elif (current == 5):
			rebind_key("interact",event)
		elif (current == 6):
			rebind_key("back",event)
		elif (current == 7):
			rebind_key("menu",event)

func rebind_key(event: String, action: InputEventKey) -> void:
	InputMap.action_erase_events(event)
	InputMap.action_add_event(event,action)
	listening = false
	update()
	
func get_key(action: String) -> String:
	var event = InputMap.action_get_events(action)
	if (event.size() > 0):
		return event[0].as_text().trim_suffix(" (Physical)")
	return "___"
