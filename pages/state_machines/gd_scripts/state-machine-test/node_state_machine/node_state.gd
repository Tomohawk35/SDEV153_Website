@abstract
extends Node
class_name NodeState

@warning_ignore("unused_signal")
signal transition_request(new_state_name: String)

@abstract
func handle_input(_event: InputEvent) -> void

@abstract
func update(_delta: float) -> void

@abstract
func physics_update(_delta: float) -> void

@abstract
func enter() -> void

@abstract
func exit() -> void
