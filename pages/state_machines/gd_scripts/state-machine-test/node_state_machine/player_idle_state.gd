extends NodeState
class_name PlayerIdleNodeState

@export var player : Player

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		transition_request.emit("attack")

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var direction : float = Input.get_axis("move_left", "move_right")
	
	if direction != 0.0:
		transition_request.emit("move")

func enter() -> void:
	player.animated_sprite_2d.play("idle")

func exit() -> void:
	pass
