class_name HealthComponent
extends Node2D

signal damaged(hurt_box: HurtBox)
signal destroyed(hurt_box: HurtBox)

@export var max_health: float = 100.0
var health: float


func _ready():
	health = max_health


func damage(hurt_box: HurtBox) -> void:
	health -= hurt_box.damage
	if health > 0:
		damaged.emit(hurt_box)
	else:
		destroyed.emit(hurt_box)
		#Temporary commented code
		#damaged.emit(hurt_box)
		#update(99)


func update(delta: int) -> void:
	# May want to change health/max health to int and use clampi
	# May want to use this in damage function
	health = clampf(health + delta, 0, max_health)
