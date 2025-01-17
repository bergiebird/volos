@icon("res://addons/_ToyBox/Icons/node_2D/icon_puzzle.png")
class_name GrenadeThrowerTrait
extends Node

@export var projectile: PackedScene
@onready var main = get_tree().get_first_node_in_group("DestructableGroup")
@onready var parent = get_parent()
@export var throw_speed = 100
@export var debug: bool = false

func _ready()->void:
	if main == null:
		push_error("No TileMapsLayers found in DestructableGroup.")

func _physics_process(_delta):
	if Input.is_action_just_released('throw'):
		throw()
		#if debug or parent.debug: print(self.name, ': KEY released')

#TODO: Currently only throws to the right of character. Will need to adjust so throwing can happen omnidirectionally.
func throw()->void:
	var instance = projectile.instantiate()
	var mouse_pos = parent.get_global_mouse_position()
	var throw_direction = (mouse_pos - parent.global_position).angle()
	#if debug or parent.debug:
		#print(self.name, ':throw()', ' |instance: ', instance.name, ' |mouse_pos:', mouse_pos, \
		#' |throw_direction:', throw_direction)
	instance.setup(parent.global_position, parent.rotation, throw_direction, throw_speed)
	main.add_child.call_deferred(instance)
