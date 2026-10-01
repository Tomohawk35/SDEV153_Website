extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.transition_request.connect(_on_transition_requested)
	
	current_state = initial_state
	await owner.ready
	current_state.enter()


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func _process(delta: float) -> void:
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)


func _on_transition_requested(new_state: State) -> void:
	pass