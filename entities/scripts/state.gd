class_name State
extends Node

@export var anim_name: String = "idle"

# Reference to Entity the State belongs to
var entity: Entity
#var state_machine: StateMachine


func _ready() -> void:
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
