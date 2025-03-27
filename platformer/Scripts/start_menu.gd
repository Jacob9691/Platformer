extends Control

var last_scene: PackedScene = null
var first_scene: PackedScene = null
var save_path = "user://game_data.save"
var last_level = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	first_scene = load("res://Scenes/level_1.tscn")
	
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		var json_string = save_file.get_line()
		var save_data = JSON.parse_string(json_string)
		last_level = save_data["last_level"]
		save_file.close()
	
	if last_level.length() > 0:
		%Resume.visible = true
		last_scene = load(last_level)


func delete_save_data():
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	var save_data = {
		"last_level": ""
	}
	var json_string = JSON.stringify(save_data)
	save_file.store_line(json_string)
	save_file.close()


func _on_resume_pressed() -> void:
	get_tree().change_scene_to_packed(last_scene)


func _on_new_game_pressed() -> void:
	Global.came_from_previous_level = false
	delete_save_data()
	get_tree().change_scene_to_packed(first_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()
