class_name HitboxComponent
extends Area2D

@export var health_component : HealthComponent


func damage() -> void:
	if health_component:
		health_component.damage()
