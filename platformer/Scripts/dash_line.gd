extends Line2D

var point_history = []
var max_points = 50
var lifetime = 0.5

func _ready():
	width = 20.0 

func _process(delta):
	# Add current global position to point history
	point_history.push_front(get_parent().global_position)
	
	# Remove old points
	if point_history.size() > max_points:
		point_history.pop_back()
	
	# Update line points
	clear_points()
	for point in point_history:
		add_point(to_local(point))
	
	# Fade out
	modulate.a = max(0, modulate.a - delta / lifetime)
	if modulate.a <= 0:
		queue_free()
