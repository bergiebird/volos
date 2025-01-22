@icon("res://addons/_ToyBox/Icons/node_2D/icon_area_meteo.png")
extends Node2D

@export var info_node: TextureRect
var mouse_left_down: bool = false
var mouse_right_down: bool = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			if get_parent().get_child(0).position.y <= 64:
				get_child(info_node.layer_index).set_cell((get_parent().get_child(0).position / 16) as Vector2i, info_node.index, info_node.coords)
				print((get_parent().get_child(0).position) as Vector2i)
				mouse_left_down = true
		elif event.button_index == 1 and not event.is_pressed():
			mouse_left_down = false
		elif event.button_index == 2 and event.is_pressed():
			get_child(info_node.layer_index).erase_cell((get_parent().get_child(0).position / 16) as Vector2i)
			mouse_right_down = true
		elif event.button_index == 2 and not event.is_pressed():
			mouse_right_down = false


	if event is InputEventMouseMotion:
		get_parent().get_child(0).position = round((get_global_mouse_position() - Vector2(8, 8)) / 16) * 16
		if mouse_left_down and get_parent().get_child(0).position.y <= 64:
			get_child(info_node.layer_index).set_cell((get_parent().get_child(0).position / 16) as Vector2i, info_node.index, info_node.coords)
		elif mouse_right_down:
			get_child(info_node.layer_index).erase_cell((get_parent().get_child(0).position / 16) as Vector2i)