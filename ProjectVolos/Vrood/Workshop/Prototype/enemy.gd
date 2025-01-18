extends Area2D

@export var tile_size: int = 16

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size/2) # snap character to grid
