extends State

@export var knockback_speed: float = 400.0
@export var decelerate_speed: float = 10.0

var _direction := Vector2.ZERO


func init() -> void:
	entity.health_component.destroyed.connect(_on_destroyed)


func enter() -> void:
	entity.is_invulnerable = true
	_direction = entity.global_position.direction_to(PlayerManager.player.global_position)
	entity.direction = _direction
	entity.velocity = _direction * -knockback_speed
	entity.update_animation(anim_name)
	entity.animation_player.animation_finished.connect(_on_animation_finished)


func process(delta: float) -> State:
	entity.velocity -= entity.velocity * decelerate_speed * delta
	return null


func _on_destroyed() -> void:
	get_parent().change_state(self)


func _on_animation_finished(_anim_name: String) -> void:
	entity.queue_free()
