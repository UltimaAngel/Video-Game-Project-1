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
	direction = new_dir.normalized()


func set_cardinal_direction(value: Vector2) -> void:
	cardinal_direction = value
	# Scale the player sprite across x axis. This particular method allows us to
	# also "flip" children of Sprite2D node.
	entity_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	match value:
		Vector2.DOWN:
			anim_direction = "down"
			interactions.rotation_degrees = 0
		Vector2.UP:
			anim_direction = "up"
			interactions.rotation_degrees = 180
		Vector2.LEFT:
			anim_direction = "side"
			interactions.rotation_degrees = 90
		Vector2.RIGHT:
			anim_direction = "side"
			interactions.rotation_degrees = -90
		_:
			anim_direction = "down"
			interactions.rotation_degrees = 0


func _on_melee_attack() -> void:
	hurt_box.direction = cardinal_direction
