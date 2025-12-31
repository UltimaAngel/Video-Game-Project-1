class_name State_Walk
extends State

@export var move_speed: float = 300.0

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"


# Player enters State
func enter() -> void:
	entity.update_animation("walk")


# Player exits State
func exit() -> void:
	pass


func process(_delta: float) -> State:
	if entity.direction == Vector2.ZERO:
		return idle

	entity.velocity = entity.direction * move_speed
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("click"):
		return attack
	return null
