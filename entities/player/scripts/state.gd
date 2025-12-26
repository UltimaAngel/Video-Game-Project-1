class_name State
extends Node

# Reference to Player the State belongs to
static var player: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Player enters State
func Enter() -> void:
	pass


# Player exits State
func Exit() -> void:
	pass


func Process(_delta: float) -> State:
	return null


func Physics(_delta: float) -> State:
	return null


func HandleInput(_event: InputEvent) -> State:
	return null
