class_name State_Attack
extends State

var attacking: bool = false

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AttackEffectAnimation"
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"


# Player enters State
func Enter() -> void:
	player.update_animation("attack")
	attack_anim.play("attack_" + player.anim_direction())
	animation_player.animation_finished.connect(EndAttack)
	attacking = true


# Player exits State
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	pass


func Process(_delta: float) -> State:
	player.velocity = Vector2.ZERO

	if attacking == false:
		if player._input_direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null


func Physics(_delta: float) -> State:
	return null


func HandleInput(_event: InputEvent) -> State:
	return null


func EndAttack(_newAnimName: String) -> void:
	attacking = false
