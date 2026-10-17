extends Node

signal new_day(day: int)
signal time_changed(time: float, delta: float)

# The duration of a full day in the game, in minutes. This can be adjusted to make days longer or shorter.
const DAY_DURATION_IN_MINUTES : float = 10.0
const SECONDS_PER_DAY_IN_GAME : float = DAY_DURATION_IN_MINUTES * 60.0

# The current day number and the percentage of the current day that has passed (0.0 to 1.0).
var day : int = 1
var time_of_day_percentage : float = 0.0
var running : bool = false

func _process(delta: float) -> void:
	if not running:
		return
	
	time_of_day_percentage += delta / SECONDS_PER_DAY_IN_GAME
	
	if time_of_day_percentage >= 1.0:
		time_of_day_percentage -= 1.0
		day += 1
		new_day.emit(day)
	
	time_changed.emit(time_of_day_percentage, delta)

# Helper functions to control the time manager
func start() -> void:
	running = true

func stop() -> void:
	running = false

func reset() -> void:
	day = 1
	time_of_day_percentage = 0.0