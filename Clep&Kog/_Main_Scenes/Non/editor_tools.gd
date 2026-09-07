@icon("res://Warehouse/Icons/node/icon_gear.png")
extends Node
class_name GameEditorTools

func _ready() -> void:
	for child in get_children():
		child.queue_free()
