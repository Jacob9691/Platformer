extends Area2D

var previous_scene: PackedScene = null

func _ready() -> void:
	load_previous_scene()

func load_previous_scene() -> void:
	var current_scene = get_tree().current_scene.name
	var level_number = current_scene.split("_")[1].to_int()
	var previous_level = level_number - 1
	var previous_scene_name = "level_" + str(previous_level)
	var previous_scene_path = "res://Scenes/" + previous_scene_name + ".tscn"
	
	previous_scene = load(previous_scene_path)

func _on_body_entered(body: Node2D) -> void:
	Global.came_from_previous_level = true
	
	if previous_scene:
		get_tree().change_scene_to_packed(previous_scene)
	else:
		print("Previous scene not loaded!")
