extends Area2D

var score = 0

func _on_body_entered(body):
	if body.name == "Player":
		score += 1
		body.speed += 25
		
		# UPDATE THE UI
		get_node("/root/World/CanvasLayer/ScoreLabel").text = "Score: " + str(score)
		
		# DYNAMIC RESPAWN
		# 1. Ask the window EXACTLY how big it is right now
	# Get the window size
	var new_x = randf_range(100, 1100)
	var new_y = randf_range(100, 650)

# Use 'global_position' instead of just 'position' to be safe
	global_position = Vector2(new_x, new_y)
