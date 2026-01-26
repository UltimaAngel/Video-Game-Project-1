class_name HealthComponent
extends Node2D

signal damaged
signal destroyed

@export var _max_health: float = 100.0
var _health: float


func _ready():
	_health = _max_health


func damage(damage_taken: int) -> void:
	_health -= damage_taken
	if _health > 0:
		damaged.emit()
	else:
		destroyed.emit()
