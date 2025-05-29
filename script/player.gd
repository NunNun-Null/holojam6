extends CharacterBody3D
class_name Player

var _speed: int = 150
var _jump_power: int = 100

var can_move = true

func _init() -> void:
	GlobalManager.set_player(self)
	SignalManager.on_dialogue_pushed.connect(disable_walk)
	SignalManager.on_dialogue_finished.connect(enable_walk)

func _ready() -> void:
	if (!PlayerManager.has_init):
		PlayerManager.start_up()
	set_collision_layer_value(1,false)
	await get_tree().create_timer(1).timeout
	set_collision_layer_value(1,true)

func _physics_process(delta: float) -> void:
	if (can_move):
		var input_direction: Vector2 = input()
		movement(input_direction,delta)
		move_and_slide()

func input() -> Vector2:
	var dir: Vector2 = Input.get_vector("move_right","move_left","move_down","move_up")
	return dir

func movement(input_dir: Vector2, delta: float) -> void:
	var direction: Vector3 = Vector3(input_dir.x,0,input_dir.y)
	velocity = direction * delta * _speed

func set_speed(speed: int) -> void:
	_speed = speed

func set_jump_power(jump: int) -> void:
	_jump_power = jump

func enable_walk() -> void:
	can_move = true

func disable_walk() -> void:
	can_move = false
