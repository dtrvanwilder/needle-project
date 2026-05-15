extends StaticBody2D

var velocity = Vector2(200, 200) 
var screen_size: Vector2

func _ready() -> void:
	# Lock down the exact same 1920x1080 canvas bounds as your player
	screen_size = Vector2(1920, 1080)

func _physics_process(delta: float) -> void:
	# Move the bouncer obstacle
	position += velocity * delta
	
	# Establish an offset padding matching the Wall's ColorRect width/height
	var half_width = 39
	var half_height = 37
	
	# Bounce cleanly off the Left/Right canvas edges
	if position.x < half_width or position.x > screen_size.x - half_width:
		velocity.x *= -1
		# Clamp it slightly inside to prevent getting stuck in a boundary loop
		position.x = clamp(position.x, half_width, screen_size.x - half_width)
		
	# Bounce cleanly off the Top/Bottom canvas edges
	if position.y < half_height or position.y > screen_size.y - half_height:
		velocity.y *= -1
		position.y = clamp(position.y, half_height, screen_size.y - half_height)
