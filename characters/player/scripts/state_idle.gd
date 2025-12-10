class_name State_Idle
extends State

@onready var walk: State = $"../Walk"


# Player enters State
func Enter() -> void:
	player.update_animation("idle")


# Player exits State
func Exit() -> void:
	pass


func Process(_delta: float) -> State:
	if player._input_direction != Vector2.ZERO:
		return walk

	player.velocity = Vector2.ZERO
	return null


func Physics(_delta: float) -> State:
	return null


func HandleInput(_event: InputEvent) -> State:
	return null
