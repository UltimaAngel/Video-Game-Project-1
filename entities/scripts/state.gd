class_name State
extends Node

@export var anim_name: String = "idle"
@export var next_state: State

# Reference to Entity the State belongs to
var entity: Entity


func _ready() -> void:
	pass


func init() -> void:
	pass


# Entity enters State
func enter() -> void:
	pass


# Entity exits State
func exit() -> void:
	pass


func process(_delta: float) -> State:
	return null


func physics(_delta: float) -> State:
	return null
