class_name State_Stun
extends State

var _prev_dir := Vector2.ZERO

@export var move_speed: float = 100.0
@export var invulnerable_duration: float = 0.5

var hurt_box: HurtBox
var direction: Vector2

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"


func init() -> void:
	entity.health_component.damaged.connect(_entity_damaged)


# Player enters State
func enter() -> void:
	# May need to use other animations depending on entered state
	entity.update_animation("walk")
	entity.effect_animation_player.play("damaged")
	entity.effect_animation_player.animation_finished.connect(_animation_finished)
	entity.make_invulnerable(invulnerable_duration)


# Player exits State
func exit() -> void:
	next_state = null
	entity.effect_animation_player.animation_finished.disconnect(_animation_finished)


func process(_delta: float) -> State:
	if entity.direction == Vector2.ZERO:
		return idle

	entity.velocity = entity.direction * move_speed

	if entity.direction != _prev_dir:
		entity.update_animation("walk")
	_prev_dir = entity.direction
	#return null
	return next_state


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("click"):
		return attack
	return null


func _entity_damaged(_hurt_box: HurtBox) -> void:
	hurt_box = _hurt_box
	state_machine.change_state(self)


func _animation_finished(_a: String) -> void:
	# Next state is always idle, may want it to be different depending on enetered state
	next_state = idle
