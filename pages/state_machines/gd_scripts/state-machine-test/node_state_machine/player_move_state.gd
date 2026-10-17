extends NodeState
class_name PlayerMoveNodeState

@export var player : Player

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		transition_request.emit("attack")

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var direction : float = Input.get_axis("move_left", "move_right")
	
	if direction == 0:
		transition_request.emit("idle")
		return
	
	if direction > 0:
		player.animated_sprite_2d.flip_h = false
	else:
		player.animated_sprite_2d.flip_h = true
	player.velocity.x = direction * player.speed
	player.move_and_slide()

func enter() -> void:
	player.animated_sprite_2d.play("move")

func exit() -> void:
	pass
