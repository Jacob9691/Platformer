extends Control

var save_path = "user://game_data.save"
var start_scene: PackedScene = null

func _ready() -> void:
	start_scene = load("res://Scenes/start_page.tscn")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")


func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func save_game():
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	var save_data = {
		"last_level": "res://Scenes/" + get_tree().current_scene.name + ".tscn"
	}
	var json_string = JSON.stringify(save_data)
	save_file.store_line(json_string)
	save_file.close()


func _process(_delta: float) -> void:
	if !Global.won_game:
		if Input.is_action_just_pressed("esc") and !get_tree().paused:
			pause()
		elif Input.is_action_just_pressed("esc") and get_tree().paused:
			resume()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_save_and_quit_pressed() -> void:
	save_game()
	get_tree().paused = false
	get_tree().change_scene_to_packed(start_scene)
