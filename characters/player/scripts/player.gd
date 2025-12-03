extends CharacterBody2D
## Player code including movement and states.
##
## A portion of the code in this script (regarding playing idle/walking animations)
## is directly inspired by or taken from Michael Games's "Make a 2D Action & Adventure
## RPG in Godot 4" tutorial series on YouTube:
## https://www.youtube.com/playlist?list=PLfcCiyd_V9GH8M9xd_QKlyU8jryGcy3Xa

@export var animation_player: AnimationPlayer
@export var player_sprite: Sprite2D

var speed: float = 300.0
var _cardinal_direction := Vector2.DOWN:
	set = set_cardinal_direction
var _input_direction := Vector2.ZERO
var _state: String = "idle"


func _ready():
	update_animation()


func _process(_delta):
	pass


func _physics_process(_delta):
	get_input()
	if set_state() or set_direction():
		update_animation()
	move_and_slide()


func anim_direction() -> String:
	match _cardinal_direction:
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


func get_input() -> void:
	_input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = _input_direction * speed


func set_cardinal_direction(value) -> void:
	# Scale the player sprite across x axis. This particular method allows us to
	# also "flip" children of Sprite2D node.
	_cardinal_direction = value
	player_sprite.scale.x = -1 if _cardinal_direction == Vector2.LEFT else 1


func set_direction() -> bool:
	# Keep same sprite direction if player stops moving
	if _input_direction == Vector2.ZERO:
		return false

	var abs_x: float = abs(_input_direction.x)
	var abs_y: float = abs(_input_direction.y)
	var new_dir: Vector2 = _cardinal_direction

	# Perfectly diagonal movement will not change the sprite direction
	if abs_x == abs_y:
		return false
	elif abs_x > abs_y:
		new_dir = Vector2.LEFT if _input_direction.x < 0 else Vector2.RIGHT
	else:
		new_dir = Vector2.UP if _input_direction.y < 0 else Vector2.DOWN

	if new_dir == _cardinal_direction:
		return false
	_cardinal_direction = new_dir
	return true


func set_state() -> bool:
	var new_state: String = "idle" if _input_direction == Vector2.ZERO else "walk"
	if new_state == _state:
		return false
	_state = new_state
	return true


func update_animation() -> void:
	animation_player.play(_state + "_" + anim_direction())
