class_name EnemyStateStun
extends State

@export var knockback_speed: float = 400.0
@export var decelerate_speed: float = 10.0

var _direction := Vector2.ZERO
var _is_anim_finished: bool = false


func init() -> void:
	entity.health_component.damaged.connect(_on_damaged)


func enter() -> void:
	entity.is_invulnerable = true
	_is_anim_finished = false
	_direction = entity.global_position.direction_to(PlayerManager.player.global_position)
	entity.direction = _direction
	entity.velocity = _direction * -knockback_speed
	entity.update_animation(anim_name)
	entity.animation_player.animation_finished.connect(_on_animation_finished)


func process(delta: float) -> State:
	if _is_anim_finished == true:
		return next_state
	entity.velocity -= entity.velocity * decelerate_speed * delta
	return null


func exit() -> void:
	entity.animation_player.animation_finished.disconnect(_on_animation_finished)
	entity.is_invulnerable = false


func _on_damaged() -> void:
	get_parent().change_state(self)


func _on_animation_finished(_anim_name: String) -> void:
	_is_anim_finished = true
