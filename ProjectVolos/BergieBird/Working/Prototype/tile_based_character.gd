class_name TileBasedCharacter
extends Area2D

@export var tile_size:int = 16

func _ready()->void:
	snap_to_grid()

func snap_to_grid(): #NOTE has tendency to snap character down and to the right one tile
	position = position.snapped(Vector2.ONE * tile_size/2)
