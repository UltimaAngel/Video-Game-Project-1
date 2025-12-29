class_name Entity
extends CharacterBody2D
## Player code including movement and states.
##
## A portion of the code in this script (regarding playing idle/walking animations)
## is directly inspired by or taken from Michael Games's "Make a 2D Action & Adventure
## RPG in Godot 4" tutorial series on YouTube:
## https://www.youtube.com/playlist?list=PLfcCiyd_V9GH8M9xd_QKlyU8jryGcy3Xa

@export var animation_player: AnimationPlayer
@export var entity_sprite: Sprite2D

var cardinal_direction := Vector2.DOWN:
	set = set_cardinal_direction
var direction := Vector2.ZERO:
	set = set_direction


func _physics_process(_delta):
	move_and_slide()


func anim_direction() -> String:
	match cardinal_direction:
		Vector2.LEFT:
			return "side"
		Vector2.RIGHT:
			return "side"
		Vector2.UP:
			return "up"
		Vector2.DOWN:
			return "down"
		_:
			return "down"


func set_cardinal_direction(value: Vector2) -> void:
	# Scale the player sprite across x axis. This particular method allows us to
	# also "flip" children of Sprite2D node.
	cardinal_direction = value
	entity_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1


func set_direction(value: Vector2) -> void:
	direction = value

	# Keep same sprite direction if player stops moving
	if value == Vector2.ZERO:
		return

	var abs_x: float = abs(value.x)
	var abs_y: float = abs(value.y)
	var new_dir: Vector2 = cardinal_direction

	# Diagonal movement will not change the sprite direction
	if abs_x == abs_y:
		if cardinal_direction.x != 0:
			new_dir.x = -1 if value.x < 0 else 1
		else:
			new_dir.y = -1 if value.y < 0 else 1
	elif abs_x > abs_y:
		new_dir = Vector2.LEFT if value.x < 0 else Vector2.RIGHT
	else:
		new_dir = Vector2.UP if value.y < 0 else Vector2.DOWN

	if new_dir == cardinal_direction:
		return
	cardinal_direction = new_dir
	update_animation("walk")


func update_animation(state: String) -> void:
	animation_player.play(state + "_" + anim_direction())
