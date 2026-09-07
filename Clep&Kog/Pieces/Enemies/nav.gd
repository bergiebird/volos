extends Node
class_name Nav

enum Who{KOG, CLEP}

@export var who_we_tracking: Who = Who.CLEP
var tracking_info: Node2D
var current_path: Array[Vector2i]
@onready var walls: TileMapLayer = get_tree().get_first_node_in_group(&"Walls")
@onready var parent: Node2D = get_parent()
@onready var astar: AStarGrid2D = AStarGrid2D.new()


func _ready() -> void:
	match who_we_tracking:
		Who.CLEP: tracking_info = Clep.self_ref
		Who.KOG:  tracking_info = Kog.self_ref
	tracking_info.has_moved.connect(_track_targets_new_position)
	if not walls:
		print_debug(" \nThere is no node in this level with the group StringName: Walls\n")
	var tilemap_size: Vector2i = walls.get_used_rect().end - walls.get_used_rect().position
	astar.region = Rect2i(Vector2i(11, 8), tilemap_size)
	astar.cell_size = L.TILE_SIZE
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	for x: int in tilemap_size.x:
		for y: int in tilemap_size.y:
			var coords: Vector2i = Vector2i(x, y) + Vector2i(11, 8)
			if walls.get_cell_tile_data(coords):
				astar.set_point_solid(coords)
	tracking_info = Clep.self_ref
	current_path = astar.get_id_path(
		walls.local_to_map(parent.global_position),
		walls.local_to_map(tracking_info.global_position)).slice(1)
	_track_targets_new_position()


func _track_targets_new_position() -> void:
	current_path = astar.get_id_path(
		walls.local_to_map(parent.global_position),
		walls.local_to_map(tracking_info.global_position)).slice(1)
