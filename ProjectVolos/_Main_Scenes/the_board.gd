@icon("res://Warehouse/Icons/node_2D/icon_chest.png")
extends Node2D

@onready var vfx_capture = preload("res://ProjectVolos/Gyms/VfxGym/vfx_capture.tscn")
@onready var klep :Node = %Klep
@onready var timer :Timer = %OneSecond
var count :int = 0
var vfx_on :bool = false
func _ready()->void:
	Signalton.initiate_capture.connect(put_vfx_on_klep)

func put_vfx_on_klep()->void:
	var vfx = vfx_capture.instantiate()
	vfx.position = klep.position + Vector2(8,8)
	vfx_on = true
	vfx.z_index = 999
	add_child(vfx)
	vfx.emitting = true
