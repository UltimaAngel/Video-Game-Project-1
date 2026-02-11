class_name HurtBox
extends Area2D

signal melee_attack

@export var damage: int = 1
@export_enum("Melee") var attack_type: int

var direction := Vector2.ZERO


func _ready() -> void:
	area_entered.connect(AreaEntered)


func AreaEntered(a: Area2D) -> void:
	if attack_type == 0:
		melee_attack.emit()
	if a is HitBox:
		a.TakeDamage(self)
