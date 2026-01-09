class_name StateMachine
extends Node

var current_state: State


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(current_state.process(delta))


func _physics_process(delta: float) -> void:
	change_state(current_state.physics(delta))


func initialize(entity: Entity) -> void:
	for c in get_children():
		assert(c is State)
		c.entity = entity
		c.init()
	change_state(get_child(0))
	process_mode = Node.PROCESS_MODE_INHERIT


func change_state(new_state: State) -> void:
	if new_state == null or new_state == current_state:
		return

	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
