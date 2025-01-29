extends Area2D

var astar = AStarGrid2D.new()
var current_path: Array[Vector2i]
var walls: TileMapLayer
var kog
var goblin
var kog_move_count: int = 1
var gob_move_count: int = 1

func _ready():

    walls = get_parent().get_parent().get_parent().get_node("Walls")
    var tilemap_size = walls.get_used_rect().end - walls.get_used_rect().position

    astar.region = Rect2i(Vector2i(11, 8), tilemap_size)
    astar.cell_size = Vector2(16, 16)
    astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
    astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
    astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
    astar.update()

    for i in tilemap_size.x:
        for j in tilemap_size.y:
            var coords = Vector2i(i, j) + Vector2i(11, 8)
            var tile_data = walls.get_cell_tile_data(coords)
            if tile_data:
                astar.set_point_solid(coords)
    
    goblin = get_parent().get_node("LootGoblin")
    current_path = astar.get_id_path(
        walls.local_to_map(global_position),
        walls.local_to_map(goblin.global_position)
    ).slice(1)

    kog = get_parent().get_node("Kog")
    if kog:
        kog.kog_moved.connect(move)
    if goblin:
        goblin.gob_moved.connect(goblin_move)

func goblin_move():
    gob_move_count += 1
    kog_move_count -= 1

    goblin = get_parent().get_node("LootGoblin")
    current_path = astar.get_id_path(
        walls.local_to_map(global_position),
        walls.local_to_map(goblin.global_position)
    ).slice(1)
    move()

func move():
    kog_move_count += 1
    var seed_gen = kog_move_count * gob_move_count
    
    print(rand_from_seed(seed_gen)[0] % 9)
    # TODO: add other logic for fire ball and fire walls
    if kog.position.x == position.x or kog.position.y == position.y:
        if rand_from_seed(seed_gen)[0] % 4 == 0:
            print("Spawn fire-wall at Kog")
            return
    if rand_from_seed(seed_gen)[0] % 9 == 0:
        print("Spawn fireball at goblin")
        return
    if current_path.front() == null:
        return
    var target_position = walls.map_to_local(current_path.pop_front())
    global_position = target_position - Vector2(8, 8)
