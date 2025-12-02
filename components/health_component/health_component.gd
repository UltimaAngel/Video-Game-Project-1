class_name HealthComponent
extends Node2D

@export var max_health : float = 100.0
var health : float


func _ready():
	health = max_health


func damage() -> void:
	# For now, a single attack is enough to kill
	health = 0
	get_parent().queue_free()
