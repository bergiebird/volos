@icon("res://addons/_ToyBox/Icons/control/icon_event.png")
extends Node #trigger_fuse.gd
@export_custom(PROPERTY_HINT_NONE, "suffix: sec") var fuse_timer: float = 0.1
@onready var parent = get_parent()
@export var debug:bool = false

func start_fuse()->void:
	_debug(0)
	await get_tree().create_timer(fuse_timer).timeout
	_debug(1)
	parent.start_explosion()

func _debug(num:int):
	if not debug: return
	match num:
		0: printt("Fuse Start", fuse_timer)
		1: print("Fuse End, TIME TO BOOM")
