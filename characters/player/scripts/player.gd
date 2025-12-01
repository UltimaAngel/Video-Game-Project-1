extends CharacterBody2D
# NOTES:
# 1) A portion of the code in this script (regarding playing idle/walking animations)
#    is directly inspired by or taken from Michael Games's "Make a 2D Action & Adventure 
#    RPG in Godot 4" tutorial series on YouTube:
#    https://www.youtube.com/playlist?list=PLfcCiyd_V9GH8M9xd_QKlyU8jryGcy3Xa

@export var animation_player : AnimationPlayer
@export var player_sprite : Sprite2D
var speed : float = 300.0
var _cardinal_direction : Vector2 = Vector2.DOWN
var _input_direction : Vector2 = Vector2.ZERO
var _state : String = "idle"


func anim_direction() -> String:
	match _cardinal_direction:
		Vector2.LEFT:
			return "side"
		Vector2.RIGHT:
			return "side"
		Vector2.UP:
			return "up"
		_:
			return "down"


func get_input() -> void:
	_input_direction = Input.get_vector("left", "right", "up", "down")
	print(_input_direction)
	velocity = _input_direction * speed


func set_direction() -> bool:
	# Keep same sprite direction if player stops moving
	if _input_direction == Vector2.ZERO:
		return false
		
	var new_dir : Vector2 = cardinal_direction
	var abs_x : float = abs(input_direction.x)
	var abs_y : float = abs(input_direction.y)
	
	if abs_x == abs_y:
		return false
	elif abs_x > abs_y:
		new_dir = Vector2.LEFT if input_direction.x < 0 else Vector2.RIGHT
	else:
		new_dir = Vector2.UP if _input_direction.y < 0 else Vector2.DOWN
	
	# Note that diagonal movement will not change the sprite direction
	if new_dir == _cardinal_direction:
		return false
		
	_cardinal_direction = new_dir
	
	# Scale the player sprite across x axis. Doing it this way instead of setting 
	# flip_h allows us to also "flip" children of Sprite2D node when the player 
	# sprite "flips", should we desire to do so in the future.
	player_sprite.scale.x = -1 if _cardinal_direction == Vector2.LEFT else 1
	return true


func set_state() -> bool:
	var new_state : String = "idle" if _input_direction == Vector2.ZERO else "walk"
	if new_state == _state:
		return false
	_state = new_state
	return true


func update_animation() -> void:
	animation_player.play(_state + "_" + anim_direction())


func _ready():
	update_animation()


func _physics_process(_delta):
	get_input()
	if set_state() or set_direction():
		update_animation()
	move_and_slide()


func _process(_delta):
	pass
