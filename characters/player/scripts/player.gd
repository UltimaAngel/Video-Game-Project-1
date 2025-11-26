extends CharacterBody2D

# NOTES:
# 
# 1) A portion of the code in this script (regarding playing idle/walking animations)
#    is directly inspired by or taken from Michael Games's "Make a 2D Action & Adventure 
#    RPG in Godot 4" tutorial series on YouTube:
#    https://www.youtube.com/playlist?list=PLfcCiyd_V9GH8M9xd_QKlyU8jryGcy3Xa

var cardinal_direction : Vector2 = Vector2.DOWN
var health : float = 100.0
var input_direction : Vector2 = Vector2.ZERO
var speed : float = 300.0
var state : String = "idle"

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var player_sprite : Sprite2D = $Sprite2D


func anim_direction() -> String:
	match cardinal_direction:
		Vector2.LEFT:
			return "side"
		Vector2.RIGHT:
			return "side"
		Vector2.UP:
			return "up"
		_:
			return "down"


func get_input() -> void:
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func set_direction() -> bool:
	# Keep same sprite direction if player stops moving
	if input_direction == Vector2.ZERO:
		return false
		
	var new_dir : Vector2 = cardinal_direction
	
	if input_direction.y == 0:
		new_dir = Vector2.LEFT if input_direction.x < 0 else Vector2.RIGHT
	elif input_direction.x == 0:
		new_dir = Vector2.UP if input_direction.y < 0 else Vector2.DOWN
	
	# Note that diagonal movement will also not change the sprite direction
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	
	# Flip player sprite across x axis. Doing it this way instead of setting flip_h
	# allows us to also flip children of Sprite2D node, should we desire to do so 
	# in the future.
	player_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true


func set_state() -> bool:
	var new_state : String = "idle" if input_direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true


func update_animation() -> void:
	animation_player.play(state + "_" + anim_direction())


func _ready():
	update_animation()


func _physics_process(_delta):
	get_input()
	if set_state() || set_direction():
		update_animation()
	move_and_slide()


# Check if Player's health is 0 every frame.
func _process(_delta):
	if (health == 0):
		get_tree().reload_current_scene()


# For now, anything in Layer 3 (melee attacks) that enters the hitbox will kill the player
func _on_hit_box_area_entered(area):
	health = 0
