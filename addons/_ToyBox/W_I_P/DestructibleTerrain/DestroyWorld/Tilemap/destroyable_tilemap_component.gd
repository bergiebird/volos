@icon("res://addons/_ToyBox/Icons/color/icon_area_damage.png")
class_name DestroyableTileMapComponent
extends Node2D #destroy_tilemap.gd
signal smoke_started
signal smoke_ended
@export_range(0, 1) var explosion_fall_off:float = 0
@export_range(0, 8) var variation:float = 0
@export var debug:bool = false
@export var smoke_scene: PackedScene
@export var smoke_tile_id:int = 5
@export var smoke_tile_coords:Vector2i = Vector2i(2, 6)
@export var smoke_delay:float = 0.3
@onready var parent:TileMapLayer = get_parent()

func create_explosion(global_pos:Vector2i, strength:int, named)->void:
	_debug(0, named)
	var center_coord = parent.local_to_map(parent.to_local(global_pos))
	var to_be_destroyed_coords = get_cells(center_coord, strength)
	init_explosion(center_coord, to_be_destroyed_coords, strength, named)
	await signal_about_fx(strength)
	delete_tiles(to_be_destroyed_coords)

func get_cells(center:Vector2i, strength:int)->Array[Vector2i]:
	var cells:Array[Vector2i] = []
	for x in range(-strength, strength + 1):
		for y in range(-strength, strength + 1):
			if abs(x) + abs(y) <= strength:
				var cell = center + Vector2i(x, y)
				cells.append(cell)
	return cells

func init_explosion(center_coord:Vector2i, to_be_destroyed_coords:Array[Vector2i], strength:int, named)->void:
	#print(named)
	var destroyed = 0
	parent.erase_cell(center_coord)
	for cell in to_be_destroyed_coords:
		var distance: int = abs(cell.x - center_coord.x) + abs(cell.y - center_coord.y)
		#bergie var fx_prob has been commented out for now:
		#var fx_prob: float
		#if strength <= 0: fx_prob = 1.0
		#else: fx_prob = 1.0 - (distance/float(strength)) * explosion_fall_off
		var source = parent.get_cell_source_id(cell)
		if source != -1 and source != 5:
			destroyed += 1
			spawn_explosion_fx(cell, center_coord, strength)
		parent.set_cell(cell, smoke_tile_id, smoke_tile_coords)
	_debug(1,"Should be this:",named)
	# bergie Commented out future Tilemap Collection for now
	_debug(1,"FIND IT:",get_tree().root.find_child(named, true, false))
	#PlayerInventory.add_to_tiles_in_storage(destroyed)
	#get_tree().root.find_child(named, true, false).set_collectable(destroyed)

func spawn_explosion_fx(cell:Vector2i, center_coord:Vector2i, strength:int)->void:
	var effect := smoke_scene.instantiate()
	var angle := randf() * TAU
	var offset := Vector2.from_angle(angle) * (randf() * variation)
	if strength > 0 and cell != center_coord: effect.global_position = parent.to_global(parent.map_to_local(cell)) + offset
	elif strength == 0:                       effect.global_position = parent.to_global(parent.map_to_local(center_coord)) + offset
	else:
		effect.queue_free()
		return
	add_child(effect)

func signal_about_fx(strength:int)->void:
	_debug(4,self.name,':signal_about_fx()',smoke_started,smoke_ended)
	smoke_started.emit(strength)
	await get_tree().create_timer(smoke_delay).timeout
	smoke_ended.emit(strength)

func delete_tiles(cells:Array[Vector2i])->void:
	for cell in cells:
		parent.erase_cell(cell)

func _debug(ID:int, d=null, dy=null, dyn=null, dyna=null, dynam=null, dynami=null, dynamic=null)->void:
	if not debug: return
	print('~~',self.name,'~~')
	match ID:
		0: print(d)
		1: printt(d, dy)
		2: printt(d,dy,dyn)
		3: printt(d,dy,dyn,dyna)
		4: printt(d,dy,dyn,dyna,dynam)
		5: printt(d,dy,dyn,dyna,dynami)
		6: printt(d,dy,dyn,dyna,dynamic)
