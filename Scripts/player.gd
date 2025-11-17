extends CharacterBody2D

const DEBUG = 0
const SPEED = 300.0

var health = 100

func _ready():
#   If DEBUG is on, then we'll test player mortality by setting HP to 0 after 5 seconds.
	if DEBUG:
		var timer := Timer.new()
		timer.timeout.connect(_on_timer_timeout)
		self.add_child(timer)
		timer.set_one_shot(true)
		timer.start(5.0)

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED

func _physics_process(_delta):
	get_input()
	move_and_slide()

# Check if Player's health is 0 every frame.
func _process(_delta):
	if (health == 0):
		self.queue_free()

# When DEBUG is on
func _on_timer_timeout():
	health = 0
