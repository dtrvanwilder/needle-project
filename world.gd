extends Node2D

func _process(_delta):
	# Access the Timer node and the Label node
	# str() converts the number to text, stepify() rounds it to one decimal
	var time_left = $Timer.time_left
	$CanvasLayer/TimerLabel.text = "Time: " + str(snapped($Timer.time_left, 0.1))

func _on_timer_timeout():
	print("GAME OVER! Time is up.")
	# You can add logic here later, like stopping the game!
