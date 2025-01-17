@icon("res://addons/_ToyBox/Icons/node_2D/icon_event.png")
extends Node #trigger_impact.gd
@onready var parent = get_parent()
@export var debug:bool = false

func _enable_impact()->void:
	print('not currently setup')

func _debug(num:int):
	if not debug: return
	match num:
		1: pass
