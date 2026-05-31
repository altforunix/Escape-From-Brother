extends Node

var game_started = false
var current_scene = "menu"

func _ready():
	var start_button = $StartMenu/VBoxContainer/StartButton
	var quit_button = $StartMenu/VBoxContainer/QuitButton
	
	if start_button:
		start_button.pressed.connect(_on_start_pressed)
	if quit_button:
		quit_button.pressed.connect(_on_quit_pressed)

func _on_start_pressed():
	game_started = true
	current_scene = "intro"
	_load_intro_scene()

func _on_quit_pressed():
	get_tree().quit()

func _load_intro_scene():
	var intro = preload("res://scenes/intro_scene.tscn").instantiate()
	add_child(intro)
	if has_node("StartMenu"):
		$StartMenu.hide()
