extends Area2D

var score = 0

func _on_body_entered(body):
	# If the game is already over, ignore all collisions completely
	if get_parent().is_game_over:
		return
		
	if body.name == "Player":
		score += 1
		body.speed += 25
		
		# UPDATE THE UI
		get_node("/root/World/CanvasLayer/ScoreLabel").text = "Score: " + str(score)
		
		# DYNAMIC RESPAWN
		var new_x = randf_range(100, 1100)
		var new_y = randf_range(100, 650)
		
		global_position = Vector2(new_x, new_y)
