extends Control

var start_scene: PackedScene = null

func _ready() -> void:
	start_scene = load("res://Scenes/start_page.tscn")


func _on_win_game_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		visible = true
		get_tree().paused = true
		Global.won_game = true


func _on_return_pressed() -> void:
	get_tree().paused = false
	Global.won_game = false
	get_tree().change_scene_to_packed(start_scene)
