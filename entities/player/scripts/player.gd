class_name Player
extends Entity

@export var state_machine: StateMachine


func _ready():
	state_machine.Initialize(self)


func _process(_delta):
	var new_dir: Vector2
	new_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	new_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = new_dir.normalized()
