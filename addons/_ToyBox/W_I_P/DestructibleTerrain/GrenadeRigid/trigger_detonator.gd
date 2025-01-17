@icon("res://addons/_ToyBox/Icons/node/icon_event.png")
extends Node #trigger_detonator.gd
@onready var parent = get_parent().get_parent()
@export var debug: bool = false

func _ready():
	set_process_input(false)

func _input(event):
	if event.is_action_pressed("interact"):
		_debug(0)
		parent.start_explosion()

func _debug(num:int):
	if not debug: return
	match num:
		0: print(self.name,':grenade controls, boom input, ', parent.name)
		_: print(self.name,':empty debug')
