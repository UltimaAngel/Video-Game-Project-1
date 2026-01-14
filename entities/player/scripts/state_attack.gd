class_name State_Attack
extends State

var attacking: bool = false

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decel_speed: float = 5.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AttackEffectAnimation"
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = $"../../Interactions/HurtBox"


# Player enters State
func enter() -> void:
	entity.update_animation("attack")
	attack_anim.play("attack_" + entity.anim_direction)
	animation_player.animation_finished.connect(end_attack)
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attacking = true
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true


# Player exits State
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	hurt_box.monitoring = false


func process(_delta: float) -> State:
	entity.velocity -= entity.velocity * decel_speed * _delta

	if attacking == false:
		if entity.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	return null


func end_attack(_newAnimName: String) -> void:
	attacking = false
