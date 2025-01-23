class_name TileBasedEntity
extends Area2D #tile_based_entity.gd

# Purpose: Set if a tell can be destroyed/pushed (eventually more?)
# Snaps characters to a grid defined by tile_size
@export var can_be_selected: bool = false
@export var is_destroyable: bool = false
@export var is_pushable: bool = false
@export var tile_size: int = 16
var is_pickedup: bool = false

func _ready()->void:
	snap_to_grid()

func snap_to_grid()->void: # NOTE has tendency to snap character down and to the right one tile
	position = position.snapped(Vector2.ONE * tile_size / 2)
