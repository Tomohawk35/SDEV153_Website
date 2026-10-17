extends NodeState
class_name PlayerAttackNodeState

@export var player : Player

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func enter() -> void:
	player.animated_sprite_2d.play("attack")
	player.animated_sprite_2d.animation_finished.connect(_on_attack_complete)

func exit() -> void:
	if player.animated_sprite_2d.animation_finished.is_connected(_on_attack_complete):
		player.animated_sprite_2d.animation_finished.disconnect(_on_attack_complete)

func _on_attack_complete() -> void:
	transition_request.emit("idle")
