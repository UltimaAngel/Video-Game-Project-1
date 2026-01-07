class_name EnemyStateWander
extends State

@export var wander_speed: float = 30.0

@export_category("AI")
@export var state_anim_duration: float = 0.7
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3

var _timer: float = 0.0
var _direction: Vector2


func enter() -> void:
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_anim_duration
	var rand = randi_range(0, 3)
	_direction = entity.DIR_4[rand]
	entity.velocity = _direction * wander_speed
	entity.direction = _direction
	entity.update_animation(anim_name)


func process(delta: float) -> State:
	_timer -= delta
	if _timer < 0:
		return next_state
	return null
