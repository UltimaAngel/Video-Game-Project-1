class_name HealthComponent
extends Node2D

signal damaged(hurt_box: HurtBox)
signal destroyed(hurt_box: HurtBox)

@export var _max_health: float = 100.0
var _health: float


func _ready():
	_health = _max_health


func damage(hurt_box: HurtBox) -> void:
	_health -= hurt_box.damage
	if _health > 0:
		damaged.emit(hurt_box)
	else:
		destroyed.emit(hurt_box)
		#damaged.emit(hurt_box)
		#update(99)


func update(delta: int) -> void:
	# May want to change health/max health to int and use clampi
	# May want to use this in damage function
	_health = clampf(_health + delta, 0, _max_health)
