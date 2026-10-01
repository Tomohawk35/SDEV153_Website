@abstract
extends Node
class_name State

signal transition_request(new_state: State)

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