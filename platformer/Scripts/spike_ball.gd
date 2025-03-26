extends PathFollow2D

# Variables for speed and pause duration
@export var speed: float = 0.9
@export var pause_duration: float = 0.5

# Internal state variables
var is_paused: bool = false
var pause_timer: float = 0.0
var direction: int = 1

func _ready() -> void:
	progress_ratio = 0.0

func _process(delta: float):
	if is_paused:
		pause_timer -= delta
		if pause_timer <= 0:
			is_paused = false
	else:
		if progress_ratio == 0.9:
			is_paused = true
			pause_timer = pause_duration
			direction *= -1
		else:
			progress_ratio += direction * speed * delta
