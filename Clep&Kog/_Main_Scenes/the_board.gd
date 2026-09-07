@icon("res://Warehouse/Icons/node_2D/icon_chest.png")
extends Node2D
class_name TheBoard

@export var level_name: StringName
var clep: Clep
@onready var vfx_capture: Resource = preload("res://Clep&Kog/Gyms/VfxGym/vfx_capture.tscn")


func _ready() -> void:
	if !level_name:
		level_name = name
	Signalton.initiate_capture.connect(put_vfx_on_clep)


func put_vfx_on_clep() -> void:
	if !clep:
		clep = get_tree().get_first_node_in_group(&"Clep")

	var vfx: Node = vfx_capture.instantiate()
	vfx.position = clep.position + Vector2(8,8) # DO NOT L.snap_to_tile()
	vfx.z_index = clep.z_index + 1
	add_child(vfx)
	vfx.emitting = true
