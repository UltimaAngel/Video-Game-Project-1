class_name Entity
extends CharacterBody2D
## The class that the Player, Enemies, and NPCs will derive from.
##
## A portion of the code in this script is directly inspired by or taken from Michael
## Games's "Make a 2D Action & Adventure RPG in Godot 4" tutorial series on YouTube:
## https://www.youtube.com/playlist?list=PLfcCiyd_V9GH8M9xd_QKlyU8jryGcy3Xa

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var animation_player: AnimationPlayer
@export var entity_sprite: Sprite2D
@export var health_component: HealthComponent
@export var hit_box: HitBox
@export var is_invulnerable: bool = false
@export var state_machine: StateMachine

# Signal used by Player to emit new directions
signal DirectionChanged(new_direction: Vector2)

var cardinal_direction := Vector2.DOWN:
	set = set_cardinal_direction
var direction := Vector2.ZERO:
	set = set_direction
var anim_direction: String = "down"


func _ready():
	if state_machine:
		state_machine.initialize(self)
	if hit_box:
		hit_box.Damaged.connect(_on_damaged)


func _physics_process(_delta):
	move_and_slide()


func set_cardinal_direction(value: Vector2) -> void:
	cardinal_direction = value

	# Scale the player sprite across x axis. This particular method allows us to
	# also "flip" children of Sprite2D node.
	entity_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	match value:
		Vector2.DOWN:
			anim_direction = "down"
		Vector2.UP:
			anim_direction = "up"
		_:
			anim_direction = "side"


func set_direction(value: Vector2) -> void:
	direction = value

	# Additonal moonwalk prevention
	#var direction_id: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	#var new_dir = DIR_4[ direction_id]

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

	DirectionChanged.emit(new_dir)


func update_animation(state: String) -> void:
	animation_player.play(state + "_" + anim_direction)


func _on_damaged(damage_taken: int) -> void:
	if is_invulnerable == true:
		return
	if health_component:
		health_component.damage(damage_taken)
