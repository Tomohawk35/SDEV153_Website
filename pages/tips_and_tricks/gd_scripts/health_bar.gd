extends ProgressBar
class_name HealthBar

@export var player : Player

func _ready() -> void:
    if player == null:
        return
    
    # initialize health bar values based on player
    max_value = player.max_health
    value = player.health

    # connect player's health_changed signal to update function
    player.health_changed.connect(_on_health_changed)

func _on_health_changed(new_value: int) -> void:
    value = new_value