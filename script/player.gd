extends CharacterBody3D
class_name Player

var _speed: int = 150
var _jump_power: int = 100

var squad: Array[PlayerFighter] 

var elizabeth = preload("res://script/elizabeth.gd")
# var cecilia = preload("res://script/elizabeth.gd")
# var raora = preload("res://script/elizabeth.gd")
# var gigi = preload("res://script/elizabeth.gd")

func _ready() -> void:
    GlobalManager.set_player(self)
    reset()

func reset() -> void:
    squad.clear()
    var fighter: PlayerFighter = elizabeth.instantiate()
    squad.append(fighter)

func _physics_process(delta: float) -> void:
    var input_direction: Vector2 = input()
    movement(input_direction,delta)
    move_and_slide()

func input() -> Vector2:
    var dir: Vector2 = Input.get_vector("move_right","move_left","move_back","move_forward")
    return dir

func movement(input_dir: Vector2, delta: float) -> void:
    var direction: Vector3 = Vector3(input_dir.x,0,input_dir.y)
    velocity = direction * delta * _speed

func set_speed(speed: int) -> void:
    _speed = speed

func set_jump_power(jump: int) -> void:
    _jump_power = jump

