extends Node2D

var player
var brother
var time_elapsed = 0.0
var tasks_completed = 0
var tasks_needed = 6
var all_tasks = []
var active_tasks = []
var game_over = false
var won = false
var task_zones = []

func _ready():
	player = $Player
	brother = $Brother
	
	# Set viewport size for game area
	get_viewport().size = Vector2(1000, 600)
	
	# Initialize all available tasks
	_initialize_tasks()
	
	# Select 6 random tasks
	_select_random_tasks()
	
	# Create visual task markers
	_create_task_markers()
	
	# Update UI
	_update_ui()
	
	$GameTimer.timeout.connect(_on_game_timer_tick)
	$GameTimer.start()
	
	# Connect player signals
	player.task_completed.connect(_on_task_completed)
	player.caught.connect(_on_player_caught)
	player.parents_room_reached.connect(_on_parents_room_reached)
	
	# Set up collision boundaries
	_setup_boundaries()

func _setup_boundaries():
	# Left boundary
	$BoundaryLeft.position = Vector2(-50, 300)
	$BoundaryLeft/CollisionShape2D.shape.size = Vector2(50, 600)
	
	# Right boundary
	$BoundaryRight.position = Vector2(1050, 300)
	$BoundaryRight/CollisionShape2D.shape.size = Vector2(50, 600)
	
	# Top boundary
	$BoundaryTop.position = Vector2(500, -30)
	$BoundaryTop/CollisionShape2D.shape.size = Vector2(1100, 50)
	
	# Bottom boundary
	$BoundaryBottom.position = Vector2(500, 630)
	$BoundaryBottom/CollisionShape2D.shape.size = Vector2(1100, 50)

func _initialize_tasks():
	all_tasks = [
		{"name": "Find Keys", "location": Vector2(200, 100), "id": 0},
		{"name": "Disable Alarm", "location": Vector2(400, 150), "id": 1},
		{"name": "Get Jacket", "location": Vector2(600, 200), "id": 2},
		{"name": "Grab Flashlight", "location": Vector2(300, 400), "id": 3},
		{"name": "Find Phone", "location": Vector2(700, 350), "id": 4},
		{"name": "Get Backpack", "location": Vector2(150, 500), "id": 5},
		{"name": "Unlock Window", "location": Vector2(500, 100), "id": 6},
		{"name": "Hide Evidence", "location": Vector2(800, 400), "id": 7},
		{"name": "Grab Water Bottle", "location": Vector2(250, 250), "id": 8},
		{"name": "Find Shoes", "location": Vector2(650, 450), "id": 9},
		{"name": "Get Money", "location": Vector2(100, 350), "id": 10},
		{"name": "Find Map", "location": Vector2(400, 500), "id": 11},
		{"name": "Grab Knife", "location": Vector2(750, 200), "id": 12},
		{"name": "Get Rope", "location": Vector2(50, 200), "id": 13},
		{"name": "Find Lighter", "location": Vector2(550, 350), "id": 14},
		{"name": "Get Matches", "location": Vector2(900, 100), "id": 15},
		{"name": "Find Compass", "location": Vector2(300, 600), "id": 16},
		{"name": "Grab Duct Tape", "location": Vector2(450, 600), "id": 17},
		{"name": "Get Binoculars", "location": Vector2(600, 600), "id": 18},
		{"name": "Find Medical Kit", "location": Vector2(800, 550), "id": 19},
	]

func _select_random_tasks():
	all_tasks.shuffle()
	active_tasks = all_tasks.slice(0, tasks_needed)

func _create_task_markers():
	for task in active_tasks:
		var marker = ColorRect.new()
		marker.color = Color.YELLOW
		marker.size = Vector2(30, 30)
		marker.position = task.location - Vector2(15, 15)
		$TaskMarkers.add_child(marker)
		task_zones.append({"marker": marker, "task": task})

func _update_ui():
	$UI/PanelContainer/VBoxContainer/TaskCounter.text = "Tasks: %d/%d" % [tasks_completed, tasks_needed]
	$UI/PanelContainer/VBoxContainer/TimeLabel.text = "Time: %.0fs" % time_elapsed
	
	if tasks_completed >= tasks_needed:
		$UI/PanelContainer/VBoxContainer/StatusLabel.text = "Go to Parents Room!"
		$UI/PanelContainer/VBoxContainer/StatusLabel.add_theme_color_override("font_color", Color.GREEN)
	else:
		$UI/PanelContainer/VBoxContainer/StatusLabel.text = "Status: Escaping..."
		$UI/PanelContainer/VBoxContainer/StatusLabel.add_theme_color_override("font_color", Color.WHITE)
	
	$UI/TaskList.clear()
	for i, task in enumerate(active_tasks):
		var found = false
		for zone in task_zones:
			if zone["task"] == task and not zone["marker"].visible:
				found = true
		var status = "✓" if found else "○"
		$UI/TaskList.add_item("%s %s" % [status, task.name])

func _on_game_timer_tick():
	time_elapsed += 1.0
	_update_ui()
	
	# Increase brother speed over time
	brother.speed = 180.0 + (time_elapsed * 0.5)

func _on_task_completed():
	tasks_completed += 1
	_update_ui()
	
	if tasks_completed >= tasks_needed:
		_unlock_parents_room()

func _unlock_parents_room():
	player.parents_room_unlocked = true

func _on_player_caught():
	if not game_over:
		game_over = true
		_show_game_over("CAUGHT! GAME OVER!", false)

func _on_parents_room_reached():
	if player.parents_room_unlocked and not game_over:
		game_over = true
		won = true
		_show_game_over("ESCAPED! YOU WIN!", true)

func _show_game_over(message: String, success: bool):
	var panel = PanelContainer.new()
	panel.anchor_left = 0.5
	panel.anchor_top = 0.5
	panel.anchor_right = 0.5
	panel.anchor_bottom = 0.5
	panel.offset_left = -250
	panel.offset_top = -100
	panel.offset_right = 250
	panel.offset_bottom = 100
	
	var vbox = VBoxContainer.new()
	vbox.alignment = 1
	panel.add_child(vbox)
	
	var title_label = Label.new()
	title_label.text = message
	title_label.add_theme_font_size_override("font_size", 40)
	if success:
		title_label.add_theme_color_override("font_color", Color.GREEN)
	else:
		title_label.add_theme_color_override("font_color", Color.RED)
	vbox.add_child(title_label)
	
	var stats_label = Label.new()
	stats_label.text = "Time: %.0fs\nTasks: %d/%d" % [time_elapsed, tasks_completed, tasks_needed]
	stats_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(stats_label)
	
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 100
	canvas_layer.add_child(panel)
	add_child(canvas_layer)
	
	await get_tree().create_timer(4.0).timeout
	get_tree().reload_current_scene()

func get_active_tasks():
	return active_tasks

func get_tasks_completed():
	return tasks_completed

func get_tasks_needed():
	return tasks_needed
