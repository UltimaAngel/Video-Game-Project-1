extends State

@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5

var _timer: float = 0.0


func enter() -> void:
	entity.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	entity.update_animation(anim_name)


func process(delta: float) -> State:
	_timer -= delta
	if _timer <= 0:
		return next_state
	return null
