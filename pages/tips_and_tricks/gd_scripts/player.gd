extends CharacterBody2D
class_name Player

signal health_changed(new_health: int)

var max_health : int = 100
var health : int

func _ready() -> void:
    # initialize health to maximum value
    health = max_health    

func take_damage(amount: int) -> void:
    health -= amount
    health_changed.emit(health)
