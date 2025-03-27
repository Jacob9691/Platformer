extends PathFollow2D

@export var speed: float = 1.5

var direction: int = 1

func _ready() -> void:
	progress_ratio = 0.0

func _process(delta: float):
	progress_ratio += direction * speed * delta
	
	if progress_ratio >= 1.0:
		progress_ratio = 1.0
		direction *= -1
	elif progress_ratio <= 0.0:
		progress_ratio = 0.0
		direction *= -1
		


func _on_spike_ball_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()
