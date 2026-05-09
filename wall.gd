extends StaticBody2D

var velocity = Vector2(200, 200) 
var screen_size

func _ready():
	# Get the "Subnet Range" (the window size)
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	# 1. Move the block
	position += velocity * delta
	
	# 2. Bounce off the Left/Right walls
	if position.x < 0 or position.x > screen_size.x:
		velocity.x *= -1
		
	# 3. Bounce off the Top/Bottom walls
	if position.y < 0 or position.y > screen_size.y:
		velocity.y *= -1
