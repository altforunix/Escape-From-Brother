extends CharacterBody2D

var speed = 180.0
var player
var game_scene

func _ready():
	game_scene = get_parent()
	player = game_scene.player
	var capsule = CapsuleShape2D.new()
	capsule.radius = 10
	capsule.height = 30
	$CollisionShape2D.shape = capsule

func _physics_process(delta):
	# Move towards player
	if player:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		# Clamp position to screen
		position.x = clamp(position.x, 50, 950)
		position.y = clamp(position.y, 30, 570)
