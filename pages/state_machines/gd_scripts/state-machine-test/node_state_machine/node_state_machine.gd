extends Node
class_name NodeStateMachine

@export var initial_state : NodeState

var current_state : NodeState
var states : Dictionary[String, NodeState] = {}

func _ready() -> void:
	await owner.ready
	
	for child in get_children():
		if child is NodeState:
			states[child.name.to_lower()] = child
			child.transition_request.connect(_on_transition_requested)
	
	if initial_state:
		current_state = initial_state
		current_state.enter()

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _on_transition_requested(new_state_name: String) -> void:
	var new_state : NodeState = states.get(new_state_name.to_lower())
	if not new_state or current_state == new_state:
		return
	
	current_state.exit()
	current_state = new_state
	current_state.enter()
