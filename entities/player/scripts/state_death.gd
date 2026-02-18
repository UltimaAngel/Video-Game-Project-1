class_name State_Death
extends State

@export var death_audio: AudioStream
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"


func init() -> void:
	pass


# Entity enters State
func enter() -> void:
	print("DEATH")
	entity.animation_player.play("death")
	audio.stream = death_audio
	audio.play()
	audio.finished.connect(_end_death)


# Entity exits State
func exit() -> void:
	audio.finished.disconnect(_end_death)


func process(_delta: float) -> State:
	entity.velocity = Vector2.ZERO
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	return null


func _end_death() -> void:
	entity.revive_entity()
	get_tree().reload_current_scene()
