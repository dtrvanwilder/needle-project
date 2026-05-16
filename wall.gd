# wall.gd
extends StaticBody2D

# Exposes a texture property slot directly inside the Godot Inspector
@export var custom_texture: Texture2D

func _ready() -> void:
	# If you manually dropped a custom skin onto this instance, apply it on boot
	if custom_texture != null:
		$WallSprite.texture = custom_texture
