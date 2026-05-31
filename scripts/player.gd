extends CharacterBody2D

signal task_completed
signal caught
signal parents_room_reached

var speed = 250.0
var parents_room_unlocked = false
var game_scene

@onready var sprite = $Sprite

func _ready():
	game_scene = get_parent()
	var capsule = CapsuleShape2D.new()
	capsule.radius = 10
	capsule.height = 30
	$CollisionShape2D.shape = capsule

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
	
	velocity = input_vector * speed
	move_and_slide()
	
	# Clamp position to screen
	position.x = clamp(position.x, 50, 950)
	position.y = clamp(position.y, 30, 570)
	
	# Check if reached parents room (right side of screen)
	if position.x > 920:
		parents_room_reached.emit()
	
	# Check distance to brother for capture
	var distance_to_brother = position.distance_to(game_scene.brother.position)
	if distance_to_brother < 40:
		caught.emit()
	
	# Check proximity to tasks
	for zone in game_scene.task_zones:
		if zone["marker"].visible:
			var distance = position.distance_to(zone["task"].location)
			if distance < 35:
				zone["marker"].hide()
				task_completed.emit()
				_play_task_effect()
				break

func _play_task_effect():
	var original_color = sprite.color
	sprite.color = Color.YELLOW
	await get_tree().create_timer(0.2).timeout
	sprite.color = original_color
