class_name Player
extends Entity

@onready var interactions: Node = get_node("Interactions")
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
# May not need effect animation player here, but it may be specific to Player


func _ready():
	PlayerManager.player = self
	#if health_component:
	#health_component.destroyed.connect(_on_destroyed)
	if hit_box:
		hit_box.Damaged.connect(_on_damaged)
	if state_machine:
		state_machine.initialize(self)
	hurt_box.melee_attack.connect(_on_melee_attack)

	#func _on_destroyed():
	#queue_free()


func _process(_delta):
	var new_dir: Vector2
	new_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	new_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = new_dir


# copied down from entity.gd
func set_direction(value: Vector2) -> void:
	if self.direction_lock == true:
		return
	direction = value.normalized()

	match value:
		Vector2.DOWN:
			interactions.rotation_degrees = 0
		Vector2.UP:
			interactions.rotation_degrees = 180
		Vector2.LEFT:
			interactions.rotation_degrees = 90
		Vector2.RIGHT:
			interactions.rotation_degrees = -90
		Vector2.DOWN + Vector2.LEFT:
			interactions.rotation_degrees = 45
		Vector2.DOWN + Vector2.RIGHT:
			interactions.rotation_degrees = -45
		Vector2.UP + Vector2.LEFT:
			interactions.rotation_degrees = 135
		Vector2.UP + Vector2.RIGHT:
			interactions.rotation_degrees = -135

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
		Vector2.LEFT:
			anim_direction = "side"
		Vector2.RIGHT:
			anim_direction = "side"
		_:
			anim_direction = "down"


func _on_melee_attack() -> void:
	hurt_box.direction = cardinal_direction
