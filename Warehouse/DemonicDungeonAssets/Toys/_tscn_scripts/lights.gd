@tool
extends ColorRect

@export var lights_on = false

func _process(_delta):
	color.a = 0.0 if lights_on else 1.0
