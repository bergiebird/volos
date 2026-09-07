@icon("res://Warehouse/Icons/node_2D/icon_area_meteo.png")
extends Node2D

@export var info_node: TextureRect
var mouse_left_down: bool = false
var mouse_right_down: bool = false
var mouse_middle_down: bool = false
var start_pos: Vector2 = Vector2.ZERO
var cam_start_pos: Vector2 = Vector2.ZERO
var terrains_dict: Dictionary
signal updated_file

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			if ui_check():
				place_tile()
				updated_file.emit()
				print((get_parent().get_child(0).position) as Vector2i)
				#print((get_parent().get_child(0).position/16) as Vector2i)
				mouse_left_down = true
		elif event.button_index == 1 and not event.is_pressed():
			mouse_left_down = false
		elif event.button_index == 2 and event.is_pressed():
			remove_tile()
			updated_file.emit()
			mouse_right_down = true
		elif event.button_index == 2 and not event.is_pressed():
			mouse_right_down = false
		elif event.button_index == 3 and event.is_pressed():
			start_pos = get_viewport().get_mouse_position()
			cam_start_pos = get_parent().get_child(3).position
			mouse_middle_down = true
		elif event.button_index == 3 and not event.is_pressed():
			mouse_middle_down = false
	elif event is InputEventMouseMotion:
		get_parent().get_child(0).position = round((get_global_mouse_position() - Vector2(8, 8)) / 16) * 16
		if mouse_left_down and ui_check():
			place_tile()
		elif mouse_right_down:
			remove_tile()
		elif mouse_middle_down:
			pan(get_viewport().get_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	var action: StringName = detect_input_event(event)
	var camera = get_parent().get_child(3)
	if action == "zoom_in":
		if camera.zoom.x * 1.1 < 43:
			camera.zoom = camera.zoom * 1.1
	elif action == "zoom_out":
		if camera.zoom.x * 0.9 > 1:
			camera.zoom = camera.zoom * 0.9


func place_tile():
	if info_node.terrain_index != -1:
		remove_tile()
		if terrains_dict.has(info_node.terrain_index) == false:
			terrains_dict[info_node.terrain_index] = [] as Array[Vector2i]
		var terrain_cells = terrains_dict[info_node.terrain_index]
		if terrain_cells.has((get_parent().get_child(0).position / 16) as Vector2i) == false:
			terrain_cells.append((get_parent().get_child(0).position / 16) as Vector2i)
			terrains_dict[info_node.terrain_index] = terrain_cells
			get_child(info_node.layer_index).set_cells_terrain_connect(terrain_cells, 0, info_node.terrain_index, false)
	else:
		get_child(info_node.layer_index).set_cell((get_parent().get_child(0).position / 16) as Vector2i, info_node.index, info_node.coords)

func remove_tile():
	var data: TileData = get_child(info_node.layer_index).get_cell_tile_data((get_parent().get_child(0).position / 16) as Vector2i)
	if data and data.terrain != -1:
		if terrains_dict.has(data.terrain) == false:
			return
		var terrain_cells = terrains_dict[data.terrain]
		if terrain_cells.has((get_parent().get_child(0).position / 16) as Vector2i):
			get_child(info_node.layer_index).set_cells_terrain_connect(terrain_cells, 0, -1, false)
			terrain_cells.erase((get_parent().get_child(0).position / 16) as Vector2i)
			get_child(info_node.layer_index).set_cells_terrain_connect(terrain_cells, 0, data.terrain, false)
			terrains_dict[data.terrain] = terrain_cells
	elif data:
		get_child(info_node.layer_index) \
				.erase_cell((get_parent().get_child(0).position / 16) \
					as Vector2i)

func ui_check():
	var curent_pos = get_parent().get_child(0).position
	return get_viewport().gui_get_hovered_control() == null and curent_pos.y <= 12 * 16 and curent_pos.y >= 0 and curent_pos.x <= 16 * 16 and curent_pos.x >= 0

func pan(new_pos: Vector2):
	var move_vector = new_pos - start_pos
	var new_cam_pos = cam_start_pos - move_vector * 1 / get_parent().get_child(3).zoom.x
	if (new_cam_pos).x >= -280 and (new_cam_pos).x <= 512:
		get_parent().get_child(3).position.x = new_cam_pos.x
	if (new_cam_pos).y >= -180 and (new_cam_pos).y <= 388:
		get_parent().get_child(3).position.y = new_cam_pos.y

func detect_input_event(event: InputEvent) -> StringName:
	for action in InputMap.get_actions():
		if event.is_action_pressed(action):
			return action
	return ""
