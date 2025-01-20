@icon("res://addons/_ToyBox/Icons/control/icon_target_2.png")
class_name FocusTile
extends TileBasedEntity # focus.gd : Used to highlight things on a grid, can be used to direct the camera

#@export var resource_dictionary:Resource = load("res://ProjectVolos/BergieBird/Working/resources/input_dictionary.tres")
#@onready var inputs :Dictionary = resource_dictionary.dict
#var current_dir

@onready var vfx_look_here: CPUParticles2D = $VfxLookHere


@export var camera: Camera2D

@export var move_rate :int= 120

var moving:bool= false
var tiles:int= 1


func _unhandled_input(event):
	var action = detect_input_event(event)
	# unhandled input events are done in load order,
	# thus whatever is highest in the ProjectSettings/Inputs will be what gets used
	match action:
		"pan_up": move_to_next_tile(Vector2.UP)
		"pan_left": move_to_next_tile(Vector2.LEFT)
		"pan_right": move_to_next_tile(Vector2.RIGHT)
		"pan_down": move_to_next_tile(Vector2.DOWN)
		"zoom_in": camera.zoom = Vector2(2, 2)
		"zoom_out": camera.zoom = Vector2(1, 1)



func move_to_next_tile(direction: Vector2):
	vfx_look_here.lifetime = 0.01
	position += direction * tile_size
	vfx_look_here.lifetime = 2



func _on_area_entered(area : TileBasedEntity)->void:
	area.modulate = Color.REBECCA_PURPLE
	printt(area.name, "in focus")

func _on_area_exited(area :TileBasedEntity)->void:
	area.modulate = Color.WHITE
	printt(area.name, "left focus")

func detect_input_event(event): # This guy will let us name actions literally whatever we want in prototype
	for action in InputMap.get_actions():
		if event.is_action_pressed(action): return action
	return null
