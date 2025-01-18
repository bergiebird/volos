@icon("res://addons/_ToyBox/Icons/control/icon_event.png")
extends Area2D # focus.gd
# Used to highlight things on a grid
@onready var label: Label = $Label

@export var tile_size: int = 16
@export var move_rate := 120
var moving := false
var current_dir
var tiles = 1
const INPUTS: Dictionary = {"up": Vector2.UP,
						"left": Vector2.LEFT,
						"right": Vector2.RIGHT,
						"down": Vector2.DOWN}

func _ready() -> void:
	snap_to_grid()

func _unhandled_input(event):
	if moving: return
	for direct in INPUTS.keys():
		if event.is_action_pressed(direct):
			move_to_next_tile(direct)

func move_to_next_tile(direct: StringName):
		position += INPUTS[direct] * tile_size

func snap_to_grid(): #NOTE has tendency to snap character down and to the right one tile
	position = position.snapped(Vector2.ONE * tile_size/2)


func _on_area_entered(area: Area2D) -> void:
	# enter any selection logic for the focus
	#area.set_scale(Vector2(1.2,1.2))
	printt(area.name, "in focus")

func _on_area_exited(area: Area2D) -> void:
	#area.set_scale(Vector2(1,1))
	printt(area.name, "left focus")
