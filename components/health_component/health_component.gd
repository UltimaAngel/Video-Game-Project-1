extends Node2D
class_name HealthComponent


@export var MAX_HEALTH : float = 100.0
var health : float

func _ready():
	health = MAX_HEALTH

# For now, a single attack is enough to kill
func damage():
	health = 0
	get_parent().queue_free()
