class_name State_Stun
extends State

var _prev_dir := Vector2.ZERO

@export var move_speed: float = 100.0
@export var invulnerable_duration: float = 0.5

#hurt box and direction may not actually be used here
var hurt_box: HurtBox
var direction: Vector2

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"
@onready var death: State = $"../Death"


func init() -> void:
	entity.health_component.damaged.connect(_entity_damaged)


# Player enters State
func enter() -> void:
	entity.update_animation("walk")
	entity.effect_animation_player.play("damaged")
	#Don't wait until the animation to finish to kill the player
	entity.effect_animation_player.animation_finished.connect(_animation_finished)
	entity.make_invulnerable(invulnerable_duration)


# Player exits State
func exit() -> void:
	next_state = null
	entity.effect_animation_player.animation_finished.disconnect(_animation_finished)


func process(_delta: float) -> State:
	if entity.direction == Vector2.ZERO:
		entity.update_animation("idle")

	entity.velocity = entity.direction * move_speed

	if entity.direction != _prev_dir:
		entity.update_animation("walk")
	_prev_dir = entity.direction
	return next_state


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	# Can still attack when in stun state
	# Early exit check or preventing attacking in this state may be better
	if entity.health_component._health > 0:
		if _event.is_action_pressed("click"):
			return attack
	return null


func _entity_damaged(_hurt_box: HurtBox) -> void:
	hurt_box = _hurt_box
	if state_machine.current_state != death:
		state_machine.change_state(self)


func _animation_finished(_a: String) -> void:
	next_state = idle
	if entity.health_component._health <= 0:
		next_state = death
