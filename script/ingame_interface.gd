extends Control

var is_choosing_move: bool = false
var is_choosing_target: bool = false
var is_battle_dialogue: bool = false

var selected_move_index: int = -1
var selected_move: Move

var selected_target_index: int = -1
var selected_target: Fighter

var current: PlayerFighter

var player_list: Array[PlayerFighter]

var can_continue: bool = false

func _ready() -> void:
	SignalManager.on_player_turn.connect(init_player)
	SignalManager.on_enemy_turn.connect(change_to_dialogue)
	SignalManager.on_dialogue_pushed.connect(dialogue)
	SignalManager.on_player_turn_stunned.connect(change_to_dialogue)
	if (BattleManager.get_top_fighter() is PlayerFighter):
		init_player(BattleManager.get_top_fighter())
	if (BattleManager.get_top_fighter() is EnemyFighter):
		change_to_dialogue()
		SignalManager.on_enemy_turn.emit()

func change_to_move_selector() -> void:
	print("on move")
	$"Combat Interface".visible = true
	$"Dialogue Screen".visible = false
	$"Choose Target".visible = false

	is_choosing_move = true
	is_choosing_target = false
	is_battle_dialogue = false

func change_to_target_selector() -> void:
	print("on target")
	$"Combat Interface".visible = false
	$"Choose Target".visible = true
	$"Dialogue Screen".visible = false

	is_choosing_move = false
	is_choosing_target = true
	is_battle_dialogue = false

func change_to_dialogue() -> void:
	print("on yap")
	$"Combat Interface".visible = false
	$"Choose Target".visible = false
	$"Dialogue Screen".visible = true

	is_choosing_move = false
	is_choosing_target = false
	is_battle_dialogue = true

func init_player(player: PlayerFighter) -> void:
	current = player 
	print("establishing for " + current.get_given_name())
	change_to_move_selector()
	var label: Label

	$"Combat Interface/HBoxContainer/VBoxContainer/Title".text = player.get_given_name() + "'s Turn"

	for index in range(player.valid_moves.size()):
		label = Label.new()
		label.name = str(index)
		label.text = player.valid_moves.get(index).name
		label.add_theme_font_size_override("font_size",40)
		$"Combat Interface/HBoxContainer/VBoxContainer/".add_child(label)
	
	if (!label):
		push_error("No valid moves???")
		return
	selected_move_index = 0

	selected_move = current.valid_moves.get(selected_move_index)
	$"Combat Interface/HBoxContainer/VBoxContainer/".get_child(selected_move_index+1).text = "> " + current.valid_moves.get(selected_move_index).name
	$"Combat Interface/HBoxContainer/Description".text = current.valid_moves.get(selected_move_index).name + "\n" + current.valid_moves.get(selected_move_index).get_desc()

func init_targets() -> void:
	var label: Label

	$"Choose Target/HBoxContainer/VBoxContainer/Title".text = current.get_given_name() + "'s Turn"
	if (selected_move.get_self_only()):
		selected_target = current
		player_list.clear()
		player_list.append(current)
		label = Label.new()
		label.name = "0"
		label.text = current.get_given_name()
		label.add_theme_font_size_override("font_size",40)
		$"Choose Target/HBoxContainer/VBoxContainer/".add_child(label)
	elif (selected_move.for_everyone):
		label = Label.new()
		label.name = "0"
		label.text = "> Everyone"
		label.add_theme_font_size_override("font_size",40)
		$"Choose Target/HBoxContainer/VBoxContainer/".add_child(label)
	else:
		if (!selected_move.is_for_allies()):
			for index in range(BattleManager.get_enemies_size()):
				label = Label.new()
				label.name = str(index)
				label.text = BattleManager.get_enemy_fighter(index).get_given_name()
				label.add_theme_font_size_override("font_size",40)
				$"Choose Target/HBoxContainer/VBoxContainer/".add_child(label)
		else:
			player_list.clear()
			for index in range(BattleManager.get_players_size()):
				if (BattleManager.get_player_fighter(index).get_dead()):
					continue
				label = Label.new()
				label.name = str(index)
				label.text = BattleManager.get_player_fighter(index).get_given_name()
				label.add_theme_font_size_override("font_size",40)
				$"Choose Target/HBoxContainer/VBoxContainer/".add_child(label)
			
			for player in BattleManager._players:
				if (player.get_dead()):
					continue
				player_list.append(player)
			
	if (!label):
		push_error("No valid moves???")
		return
	
	if (!selected_move.for_everyone):
		selected_target_index = 0

		if (!selected_move.is_for_allies()):
			selected_target = BattleManager.get_enemy_fighter(selected_target_index)
			selected_target.set_selected(true)
			$"Choose Target/HBoxContainer/VBoxContainer/".get_child(selected_target_index+1).text = "> " + BattleManager.get_enemy_fighter(selected_target_index).get_given_name()
		else:
			selected_target = player_list.get(selected_target_index)
			SignalManager.on_player_select.emit(selected_target)
			$"Choose Target/HBoxContainer/VBoxContainer/".get_child(selected_target_index+1).text = "> " + player_list.get(selected_target_index).get_given_name()
		
		update_desc(selected_target)
	else:

		if (!selected_move.is_for_allies()):
			for enemy in BattleManager._enemies:
				enemy.set_selected(true)
		else:
			player_list.clear()
			for player in BattleManager._players:
				if (player.get_dead()):
					continue
				player_list.append(player)
			
			for ally in player_list:
				SignalManager.on_player_select.emit(ally)


func _process(_delta: float) -> void:
	if (is_choosing_move):
		if (Input.is_action_just_pressed("choose_up") and selected_move_index > 0):
			print("going up")
			selected_move_index -= 1
			highlighted_move(selected_move_index,1)


		elif (Input.is_action_just_pressed("choose_down") and selected_move_index < current.valid_moves.size()-1):
			print("going down")
			selected_move_index += 1
			highlighted_move(selected_move_index,-1)
		
		elif (Input.is_action_just_pressed("interact")):
			if (!selected_move.has_enough_sp(current.get_special())):
				return
			change_to_target_selector()
			init_targets()

	elif (is_choosing_target):
		if (Input.is_action_just_pressed("back")):
			change_to_move_selector()
			selected_target_index = 0
			if (selected_target is EnemyFighter):
				selected_target.set_selected(false)
			elif (selected_target is PlayerFighter):
				SignalManager.on_player_unselect.emit(selected_target)
			elif (selected_move.for_everyone and selected_move.intended_for_allies):
				for player in BattleManager._players:
					SignalManager.on_player_unselect.emit(player)
			elif (selected_move.for_everyone and !selected_move.intended_for_allies):
				for enemy in BattleManager._enemies:
					enemy.set_selected(false)

			selected_target = null
			for node in $"Choose Target/HBoxContainer/VBoxContainer/".get_children():
				if (node.name == "Title"):
					continue
				node.queue_free()
		
		if (Input.is_action_just_pressed("choose_up") and selected_target_index > 0 and !selected_move.for_everyone):
			print("going up")
			selected_target_index -= 1
			highlighted_target(selected_target_index,1)


		elif (Input.is_action_just_pressed("choose_down") and selected_target_index < $"Choose Target/HBoxContainer/VBoxContainer/".get_child_count()-2 and !selected_move.for_everyone):
			print("going down")
			selected_target_index += 1
			highlighted_target(selected_target_index,-1)
		
		elif (Input.is_action_just_pressed("interact")):
			change_to_dialogue()
			clear_nodes()
			move()
	
	elif (is_battle_dialogue):
		if (Input.is_action_just_pressed("interact")):
			if (can_continue):
				can_continue = false
				$"Dialogue Screen/Text".text = ""
				DialogueManager.clear_dialogue()
				SignalManager.on_move_completed.emit()
				

func clear_nodes() -> void:
	if (selected_target is EnemyFighter):
		selected_target.set_selected(false)
	elif (selected_target is PlayerFighter):
		SignalManager.on_player_unselect.emit(selected_target)
	
	if (selected_move.for_everyone):
		if (selected_move.is_for_allies()):
			for player in player_list:
				SignalManager.on_player_unselect.emit(player)
		else:
			for enemy in BattleManager._enemies:
				enemy.set_selected(false)

	for node in $"Choose Target/HBoxContainer/VBoxContainer/".get_children():
		if (node.name == "Title"):
			continue
		node.queue_free()

	for node in $"Combat Interface/HBoxContainer/VBoxContainer/".get_children():
		if (node.name == "Title"):
			continue
		node.queue_free()

func dialogue() -> void:
	$"Dialogue Screen/Text".visible_ratio = 0
	$"Dialogue Screen/Text".text = ""
	for content in DialogueManager.get_dialogue_list():
		$"Dialogue Screen/Text".text += content + "\n"
	var tween := create_tween()
	tween.tween_property($"Dialogue Screen/Text","visible_ratio",1,2)
	await tween.finished
	print("Dialogue complete")
	can_continue = true

func highlighted_target(index: int, offset: int) -> void:
	if (!selected_move.is_for_allies()):
		$"Choose Target/HBoxContainer/VBoxContainer/".get_child(index+offset+1).text = BattleManager.get_enemy_fighter(index+offset).get_given_name()
		selected_target = BattleManager.get_enemy_fighter(index)
		selected_target.set_selected(true)
		BattleManager.get_enemy_fighter(index+offset).set_selected(false)
		$"Choose Target/HBoxContainer/VBoxContainer/".get_child(index+1).text = "> " + BattleManager.get_enemy_fighter(index).get_given_name()

	else:
		$"Choose Target/HBoxContainer/VBoxContainer/".get_child(index+offset+1).text = player_list.get(index+offset).get_given_name()
		SignalManager.on_player_unselect.emit(selected_target)
		selected_target = player_list.get(index)
		SignalManager.on_player_select.emit(selected_target)
		$"Choose Target/HBoxContainer/VBoxContainer/".get_child(index+1).text = "> " + player_list.get(index).get_given_name()
	
	update_desc(selected_target)

func update_desc(fighter: Fighter) -> void:
	$"Choose Target/HBoxContainer/Description".text = fighter.get_given_name() + "'s Stats\nHealth: " + str(fighter.get_health()) + "/" + str(fighter.get_max_health()) + "\nDefense: " + str(fighter.get_defense()) + "\nSpeed: " + str(fighter.get_speed()) +  "\n"
	if (fighter.get_mark()):
		$"Choose Target/HBoxContainer/Description".text += "Is Marked" + "\n"
	if (fighter.get_stun()):
		$"Choose Target/HBoxContainer/Description".text += "Is Stunned" + "\n"
	if (fighter.is_defended()):
		$"Choose Target/HBoxContainer/Description".text += "Defended by: " + fighter.get_defended().get_given_name() + "\n"
	if (fighter._damage_multiplier != 0):
		$"Choose Target/HBoxContainer/Description".text += "Damage taken bonus: " + str(fighter._damage_multiplier) + "\n"
	if (fighter.get_bonus_accuracy() != 0):
		$"Choose Target/HBoxContainer/Description".text += "Accuracy Bonus: " + str(fighter.get_bonus_accuracy()) + "\n"
	if (fighter._adjusted_defense != 0):
		$"Choose Target/HBoxContainer/Description".text += "Defense Bonus: " + str(fighter._adjusted_defense) + "\n"
	if (fighter.get_bonus_damage() != 0):
		$"Choose Target/HBoxContainer/Description".text += "Damage Bonus: " + str(fighter.get_bonus_damage()) + "\n"
	if (fighter._adjusted_speed != 0):
		$"Choose Target/HBoxContainer/Description".text += "Speed Bonus: " + str(fighter._adjusted_speed) + "\n"
	

func highlighted_move(index: int, offset: int) -> void:
	$"Combat Interface/HBoxContainer/VBoxContainer/".get_child(index+offset+1).text = current.valid_moves.get(index+offset).name

	selected_move = current.valid_moves.get(index)
	$"Combat Interface/HBoxContainer/VBoxContainer/".get_child(index+1).text = "> " + current.valid_moves.get(index).name
	$"Combat Interface/HBoxContainer/Description".text = current.valid_moves.get(index).name + "\n" + current.valid_moves.get(index).get_desc()

func move() -> void:
	selected_move.set_target(selected_target)
	current.play_turn(selected_move)
