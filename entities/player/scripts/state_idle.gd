class_name State_Idle
extends State

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"


# Player enters State
func enter() -> void:
	entity.update_animation("idle")


# Player exits State
func exit() -> void:
	pass


func process(_delta: float) -> State:
	if entity.direction != Vector2.ZERO:
		return walk

	entity.velocity = Vector2.ZERO
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("click"):
		return attack
	return null
