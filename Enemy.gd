# Enemy.gd
extends Area2D

var score = 0

func _on_body_entered(body: Node2D) -> void:
	if get_parent().is_game_over:
		return
		
	if body.name == "Player":
		# BODY CONTACT ONLY: The rat survives contact now.
		# You can add a screen-shake or health penalty here later.
		print("Player bumped into the rat! No damage dealt by body.")

func respawn_enemy() -> void:
	var new_x = randf_range(100, 1100)
	var new_y = randf_range(100, 650)
	global_position = Vector2(new_x, new_y)
