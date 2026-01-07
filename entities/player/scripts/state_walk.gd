class_name State_Walk
extends State

var _prev_dir := Vector2.ZERO

@export var move_speed: float = 300.0

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"


# Player enters State
func Enter() -> void:
	player.update_animation("walk")


# Player exits State
func Exit() -> void:
	pass


func Process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle

	player.velocity = player.direction * move_speed

	if player.direction != _prev_dir:
		player.update_animation("walk")
	_prev_dir = player.direction
	return null


func Physics(_delta: float) -> State:
	return null


func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("click"):
		return attack
	return null
