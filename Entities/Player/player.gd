extends CharacterBody2D

# 🏃 Movement Variables
const SPEED = 150.0

# 🛠️ References to Nodes
# Change "Sprite2D" to match the exact name of your sprite node
@onready var sprite_2d = $Sprite2D 

func _physics_process(_delta):
	# 🕹️ 1. Get input direction (-1 for Left, 1 for Right, 0 for None)
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# 🚀 2. Apply movement velocity
	if direction != 0:
		velocity.x = direction * SPEED
		
		# 🔄 3. Flip sprite direction based on movement
		sprite_2d.flip_h = (direction < 0)
		
		# 🎬 4. Play running animation
		sprite_2d.play("run") 
	else:
		# 🛑 Stop moving if no keys are pressed
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# 💤 Play idle animation
		sprite_2d.play("idle")

	# ⚙️ 5. Move the character using Godot's built-in physics
	move_and_slide()
