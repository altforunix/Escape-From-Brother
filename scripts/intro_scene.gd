extends Node

func _ready():
	$Timer.timeout.connect(_on_intro_complete)
	$Timer.start()

func _on_intro_complete():
	get_tree().change_scene_to_file("res://scenes/game_scene.tscn")
