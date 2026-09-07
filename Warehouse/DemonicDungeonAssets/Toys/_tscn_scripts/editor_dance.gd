@tool
extends Node2D

@export var dance: bool = false:
	set(value):
		dance = value
		if children:
			for child: Node in children:
				if child is AnimatedSprite2D:
					if value:
						child.play()
					else:
						child.stop()
var children: Array[Node]

func _enter_tree() -> void:
	children = get_children()
