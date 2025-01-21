@icon("res://addons/_ToyBox/Icons/control/icon_target_2.png")
class_name FocusTile
extends Area2D # focus.gd
#@export var resource_dictionary:Resource = load("res://ProjectVolos/BergieBird/Working/resources/input_dictionary.tres")
#@onready var inputs :Dictionary = resource_dictionary.dict
#var current_dir

@onready var vfx_look_here: GPUParticles2D = $VfxLookHere
@export var camera: Camera2D
@export var move_rate: int = 120
var moving: bool = false
var tiles: int = 1
# TODO Clean up Drag and Drop code

@export var tile_size: int = 16

var selected_entiy: TileBasedEntity
var entiy_below: bool = false
var picked_up: bool = false

func _ready() -> void:
	snap_to_grid()

func snap_to_grid(): # NOTE has tendency to snap character down and to the right one tile
	position = position.snapped(Vector2.ONE * tile_size / 2)


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
		"toggle_pickup":
			if selected_entiy != null and !picked_up and selected_entiy.can_be_selected:
				selected_entiy.is_pickedup = true
				picked_up = true
				printt(selected_entiy.name, "picked up")
			elif !entiy_below:
				picked_up = false
				if selected_entiy != null:
					selected_entiy.is_pickedup = false
					printt(selected_entiy.name, "Droped")
		_:
			print("Couldn't identify the action: ", action)

func move_to_next_tile(direction: Vector2) -> void:

	position += direction * tile_size
	if selected_entiy != null and picked_up:
		selected_entiy.position = position


func _on_area_entered(area: TileBasedEntity) -> void:
	if !picked_up and area.can_be_selected:
		area.modulate = Color.REBECCA_PURPLE
		selected_entiy = area
		printt(area.name, "in focus")
	else:
		entiy_below = true

func _on_area_exited(area: TileBasedEntity) -> void:
	if !picked_up:
		area.modulate = Color.WHITE
		selected_entiy = null
		printt(area.name, "left focus")
	else:
		entiy_below = false

func detect_input_event(event):
	for action in InputMap.get_actions():
		if event.is_action_pressed(action):
			return action
	return null
