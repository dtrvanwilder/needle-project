extends Node2D

var is_game_over: bool = false
var game_over_label: Label = null

func _process(_delta):
	# If game is over, monitor the R key reload protocol
	if is_game_over:
		if Input.is_key_pressed(KEY_R):
			restart_game()
		return # Stop updating the timer label once time is up
	
	# Your exact existing timer string formatting logic
	var time_left = $Timer.time_left
	$CanvasLayer/TimerLabel.text = "Time: " + str(snapped($Timer.time_left, 0.1))

func _on_timer_timeout():
	# Triggered automatically when your Timer node hits 0
	trigger_game_over()

func trigger_game_over():
	is_game_over = true
	$Timer.stop() 
	
	# Freeze the Player and Food processing loops instantly
	$Player.process_mode = PROCESS_MODE_DISABLED
	$Food.process_mode = PROCESS_MODE_DISABLED
	
	# Fetch the final score from your Food node
	var final_score = $Food.score
	
	# Build the dynamic high-fidelity display text string
	game_over_label = Label.new()
	game_over_label.text = "GAME OVER\nFinal Score: " + str(final_score) + "\nPress 'R' to Restart"
	
	# Formatting to center the labels cleanly
	game_over_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	game_over_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	game_over_label.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	
	$CanvasLayer.add_child(game_over_label)


func restart_game():
	is_game_over = false
	# Reload the current active scene grid from scratch
	get_tree().reload_current_scene()
