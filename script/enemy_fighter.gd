extends Fighter
class_name EnemyFighter

@export var speed: int = 0
@export var health: int = 1
@export var defense: int = 0

func _init() -> void:
    super(health,defense,speed)

func start_turn() -> void: 
    push_error(name + " is missing a start_turn() method")

