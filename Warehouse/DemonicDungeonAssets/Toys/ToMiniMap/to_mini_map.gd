#Bergie script, vrood/beetruth feel free to update this and fix TODO's
# A 'Manager' script. This only needs 2 children, a tilemaplayer called MiniMap and any other tilemap.
extends Node2D
@export var draw_to_minimap:bool = false
var minimap
var main_maps: Array
var cooldown: bool = false
var currently_modified:Array[Vector2i]
@export var resource:Resource = null

func _ready():
	await initialize()
func initialize():
	var children = await Taken.get_roster("MiniMap", self)
	minimap = get_node(children[0])
	main_maps = children.slice(1)
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		atlas()


# TODO: rename atlas() to something more correct.
# To be renamed, atlas() collects the contents of the minimap, then cycles through every single map that is not the minimap.
# In every non-minimap map, we check every cell to see if it doesn't yet exist in Minimap. We then give to minimap cell by cell.
#TODO: Delete minimap cells if it is empty on mainmap.
func atlas():
	var minimap_cells = minimap.get_used_cells()
	for map_name in main_maps:
		var node = get_node(map_name)
		var cells = node.get_used_cells()
		for cell in cells:
			var atlas_coord = node.get_cell_atlas_coords(cell)
			print(atlas_coord)
			if not cell in minimap_cells:
				give_to_minimap(get_node(map_name), atlas_coord, cell)

# give_to_minimap() currently just checks to see if the cell is a specific ice cell(ASAP 3,26 broken)
func give_to_minimap(map_name:Node, atlas_coord:Vector2i, minimap_cell:Vector2i)->void:
	var atlas_map = 0
	if resource: # TODO: Create resource that reads the atlas coordinates of the MainMap and then tells MiniMap what tile to use.
		pass
	elif atlas_coord == Vector2i(3,26):
		atlas_coord = Vector2i(7,9)
		atlas_map = 8
	else:
		atlas_coord = Vector2i(16,47)
		atlas_map = 4

	minimap.set_cell(minimap_cell, atlas_map, atlas_coord)
