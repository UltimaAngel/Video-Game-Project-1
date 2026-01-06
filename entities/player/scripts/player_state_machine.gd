extends StateMachine

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
