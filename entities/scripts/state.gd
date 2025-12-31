class_name State
extends Node

# Reference to Entity the State belongs to
static var entity: Entity


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
