@icon("res://addons/_ToyBox/Icons/control/icon_target_2.png")
extends Area2D # focus.gd : Used to highlight things on a grid, can be used to direct the camera
@onready var label :Label = $Label
@export var resource_dictionary:Resource = load("res://ProjectVolos/BergieBird/Working/resources/input_dictionary.tres")
@onready var inputs :Dictionary = resource_dictionary.dict
@export var tile_size :int = 16
@export var move_rate :int= 120
var moving :bool= false
var tiles :int= 1
#var current_dir

func _ready()->void:
	snap_to_grid()

func _unhandled_input(event):
	if moving:
		return
	for direct in inputs.keys():
		if event.is_action_pressed(direct):
			move_to_next_tile(direct)

func move_to_next_tile(direct :StringName):
		position += inputs[direct] * tile_size

func snap_to_grid(): #NOTE has tendency to snap character down and to the right one tile
	position = position.snapped(Vector2.ONE * tile_size/2)

func _on_area_entered(area :Area2D)->void:
	# Enter any selection logic for the focus
	#area.set_scale(Vector2(1.2,1.2))
	printt(area.name, "in focus")

func _on_area_exited(area :Area2D)->void:
	#area.set_scale(Vector2(1,1))
	printt(area.name, "left focus")
