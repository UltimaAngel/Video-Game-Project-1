class_name EnemyStateStun
extends State

@export var knockback_speed: float = 400.0
@export var decelerate_speed: float = 10.0

var _is_anim_finished: bool = false


func init() -> void:
	entity.entity_damaged.connect(_on_entity_damaged)


func enter() -> void:
	entity.is_invulnerable = true
	entity.velocity = entity.direction * -knockback_speed
	entity.update_animation(anim_name)
	entity.animation_player.animation_finished.connect(_on_animation_finished)


func process(delta: float) -> State:
	if _is_anim_finished:
		return next_state
	entity.velocity -= entity.velocity * decelerate_speed * delta
	return null


func exit() -> void:
	entity.animation_player.animation_finished.disconnect(_on_animation_finished)
	entity.is_invulnerable = false


func _on_entity_damaged() -> void:
	get_parent().change_state(self)


func _on_animation_finished(_anim_name: String) -> void:
	_is_anim_finished = true
