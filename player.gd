extends CharacterBody2D

@export var speed = 400

# Set your exact screen dimension limits (Adjust these to match your project window size!)
var min_x = 60
var max_x = 1858
var min_y = 60
var max_y = 1020

func _physics_process(_delta):
	# The Game Over guard we built yesterday
	if get_parent().is_game_over:
		velocity = Vector2.ZERO
		return
		
	# Gather movement inputs
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	

	# THE CLAMP PROTOCOL:
	# Forces the player's position to stay strictly between the min and max coordinates
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.y = clamp(global_position.y, min_y, max_y)
