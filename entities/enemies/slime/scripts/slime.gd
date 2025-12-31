class_name Slime
extends Entity

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var player: Player


func _ready():
	pass


func _process(_delta):
	pass
