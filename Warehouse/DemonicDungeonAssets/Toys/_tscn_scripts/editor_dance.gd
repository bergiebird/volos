@tool
extends Node2D

@export var dance: bool = false:
	set(value):
		dance = value
		if children:
			for child in children:
				if child is AnimatedSprite2D:
					if value:
						child.play()
					else:
						child.stop()
var children

func _enter_tree():
	children = get_children()
