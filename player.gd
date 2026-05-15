# player.gd
extends CharacterBody2D

@export var speed = 400

var screen_size: Vector2
var is_attacking_left: bool = false
var is_attacking_right: bool = false

func _ready() -> void:
	screen_size = Vector2(1920, 1080)
	
	# Lock down both weapon safe states on boot
	$SlashArea.visible = false
	$SlashArea.monitoring = false
	$SlashAreaRight.visible = false
	$SlashAreaRight.monitoring = false

func _physics_process(_delta: float) -> void:
	if get_parent().is_game_over:
		velocity = Vector2.ZERO
		return
		
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	# THE CLAMP PROTOCOL
	var padding = 60
	global_position.x = clamp(global_position.x, padding, screen_size.x - padding)
	global_position.y = clamp(global_position.y, padding, screen_size.y - padding)

	# MONITOR DUAL WEAPON COMBAT INPUTS
	if Input.is_action_just_pressed("attack_left") and not is_attacking_left and not is_attacking_right:
		execute_left_slash()
	elif Input.is_action_just_pressed("attack_right") and not is_attacking_right and not is_attacking_left:
		execute_right_slash()

func execute_left_slash() -> void:
	is_attacking_left = true
	$SlashArea.rotation_degrees = -20
	$SlashArea.visible = true
	$SlashArea.monitoring = true
	
	await get_tree().create_timer(0.06).timeout
	$SlashArea.rotation_degrees = 20
	
	await get_tree().create_timer(0.06).timeout
	$SlashArea.visible = false
	$SlashArea.monitoring = false
	$SlashArea.rotation_degrees = 0
	is_attacking_left = false

func execute_right_slash() -> void:
	is_attacking_right = true
	$SlashAreaRight.rotation_degrees = 20 # Tilts back on right side
	$SlashAreaRight.visible = true
	$SlashAreaRight.monitoring = true
	
	await get_tree().create_timer(0.06).timeout
	$SlashAreaRight.rotation_degrees = -20 # Snaps forward on right side
	
	await get_tree().create_timer(0.06).timeout
	$SlashAreaRight.visible = false
	$SlashAreaRight.monitoring = false
	$SlashAreaRight.rotation_degrees = 0
	is_attacking_right = false

# SINGLE COMBAT VERIFICATION LOGIC SHARED BETWEEN WIRES
func process_hitscan_kill(target_area: Area2D) -> void:
	if target_area.name == "Enemy":
		target_area.score += 1
		self.speed += 25
		
		# Update UI Canvas ledger
		get_node("/root/World/CanvasLayer/ScoreLabel").text = "Score: " + str(target_area.score)
		
		# Trigger the rat reposition routine
		if target_area.has_method("respawn_enemy"):
			target_area.respawn_enemy()

func _on_slash_area_area_entered(area: Area2D) -> void:
	if get_parent().is_game_over: return
	process_hitscan_kill(area)

func _on_slash_area_right_area_entered(area: Area2D) -> void:
	if get_parent().is_game_over: return
	process_hitscan_kill(area)
