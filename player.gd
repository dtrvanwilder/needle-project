extends CharacterBody2D

@export var speed = 400

# Set your exact screen dimension limits (Adjust these to match your project window size!)
var min_x = 0
var max_x = 1920
var min_y = 0
var max_y = 1080

func _physics_process(_delta):
	if get_parent().is_game_over:
		velocity = Vector2.ZERO
		return
		
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	# THE DYNAMIC AUTO-DETECTION PROTOCOL:
	# Automatically fetches the exact resolution of the screen the game is currently rendering on
	var screen_size = get_viewport_rect().size
	
	# Establish a dynamic 60-pixel sprite buffer relative to the active screen boundaries
	var padding = 60
	
	global_position.x = clamp(global_position.x, padding, screen_size.x - padding)
	global_position.y = clamp(global_position.y, padding, screen_size.y - padding)
