extends Area2D

var next_scene: PackedScene = null

func _ready() -> void:
	preload_next_scene()

func preload_next_scene() -> void:
	var current_scene = get_tree().current_scene.name
	var level_number = current_scene.split("_")[1].to_int()
	var next_level = level_number + 1
	var next_scene_name = "level_" + str(next_level)
	var next_scene_path = "res://Scenes/" + next_scene_name + ".tscn"
	
	next_scene = load(next_scene_path)

func _on_body_entered(body: Node2D) -> void:
	Global.came_from_previous_level = false
	
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
	else:
		print("Next scene not preloaded!")
