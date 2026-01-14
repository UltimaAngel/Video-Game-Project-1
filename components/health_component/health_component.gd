class_name HealthComponent
extends Node2D

@export var max_health: float = 100.0
var health: float


func _ready():
	health = max_health


func damage(damage_taken: int) -> void:
	health -= damage_taken
