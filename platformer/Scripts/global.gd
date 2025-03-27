extends Node

var came_from_previous_level : bool
var won_game : bool

func _ready() -> void:
	came_from_previous_level = false
	won_game = false
