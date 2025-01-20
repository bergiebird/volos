@icon("res://addons/_ToyBox/Icons/control/icon_target_2.png")
class_name FocusTile
extends Area2D # focus.gd
#@export var resource_dictionary:Resource = load("res://ProjectVolos/BergieBird/Working/resources/input_dictionary.tres")
#@onready var inputs :Dictionary = resource_dictionary.dict
#var current_dir

@onready var vfx_look_here: GPUParticles2D = $VfxLookHere
@export var camera: Camera2D
@export var move_rate :int= 120
var moving:bool= false
var tiles:int= 1
# TODO Drag and Drop

@export var tile_size:int = 16

func _ready()->void:
	snap_to_grid()

func snap_to_grid(): #NOTE has tendency to snap character down and to the right one tile
	position = position.snapped(Vector2.ONE * tile_size/2)


func _unhandled_input(event):
	var action = detect_input_event(event)
	match action:
		"pan_up":
			move_to_next_tile(Vector2.UP)
		"pan_left":
			move_to_next_tile(Vector2.LEFT)
		"pan_right":
			move_to_next_tile(Vector2.RIGHT)
		"pan_down":
			move_to_next_tile(Vector2.DOWN)
		"zoom_in":
			camera.zoom = Vector2(2, 2)
		"zoom_out":
			camera.zoom = Vector2(1, 1)
		_:
			print("Couldn't identify the action: ", action)

func move_to_next_tile(direction :Vector2)->void:

	position += direction * tile_size


func _on_area_entered(area :TileBasedEntity)->void:
	area.modulate = Color.REBECCA_PURPLE
	printt(area.name, "in focus")

func _on_area_exited(area :TileBasedEntity)->void:
	area.modulate = Color.WHITE
	printt(area.name, "left focus")

func detect_input_event(event):
	for action in InputMap.get_actions():
		if event.is_action_pressed(action):
			return action
	return null
