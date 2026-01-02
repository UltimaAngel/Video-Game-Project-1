class_name StateMachine
extends Node

var states: Array[State]
var prev_state: State
var current_state: State


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState(current_state.process(delta))


func _physics_process(delta: float) -> void:
	ChangeState(current_state.physics(delta))


func _unhandled_input(event: InputEvent) -> void:
	ChangeState(current_state.handle_input(event))


func Initialize(entity: Entity) -> void:
	for c in get_children():
		assert(c is State)
		c.entity = entity
		if c is State_Idle:
			ChangeState(c)
	process_mode = Node.PROCESS_MODE_INHERIT


func ChangeState(new_state: State) -> void:
	if new_state == null || new_state == current_state:
		return

	if current_state:
		current_state.exit()

	prev_state = current_state
	current_state = new_state
	current_state.enter()
