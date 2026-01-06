class_name Player
extends Entity

func _process(_delta):
	var new_dir: Vector2
	new_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	new_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = new_dir.normalized()


func _ready():
	PlayerManager.player = self
	state_machine.initialize(self)
