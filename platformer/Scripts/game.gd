extends Node2D

@onready var global = get_node("/root/Global")
@onready var player = get_node("Player")
@onready var end_point = get_node("EndPoint")
@onready var start_point = get_node("StartPoint")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.came_from_previous_level:
		player.position = end_point.position
	else:
		player.position = start_point.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
