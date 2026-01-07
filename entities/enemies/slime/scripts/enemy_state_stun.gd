class_name EnemyStateStun
extends State

@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

var _direction: Vector2
var _anim_finished: bool = false


func init() -> void:
	entity.entity_damaged.connect(_on_entity_damaged)


func enter() -> void:
	_anim_finished = false
	entity.direction = _direction
	entity.velocity = _direction * -knockback_speed
	entity.update_animation(anim_name)


func process(delta: float) -> State:
	if _anim_finished == true:
		return next_state
	entity.velocity -= entity.velocity * decelerate_speed * delta
	return null


func _on_entity_damaged() -> void:
	get_parent().change_state(self)
