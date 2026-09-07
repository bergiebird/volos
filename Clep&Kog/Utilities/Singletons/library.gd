##Library!
class_name L
extends Node


enum Difficulty {CASUAL, EASY, NORMAL, HARD, INSANE}

const CELL_LENGTH: int = 16
const TILE_SIZE: Vector2 = Vector2(CELL_LENGTH, CELL_LENGTH)

const DIFFICULTY_TO_MOVE_TIME: Dictionary[Difficulty, float] = {
		L.Difficulty.CASUAL: 2.2,
		L.Difficulty.EASY:   1.9,
		L.Difficulty.NORMAL: 1.6,
		L.Difficulty.HARD:   1.3,
		L.Difficulty.INSANE: 1.0,
}

static func snap_to_tile(pos: Vector2) -> Vector2:
	return round(pos / CELL_LENGTH) * CELL_LENGTH

static func spawn_snap(pos: Vector2) -> Vector2:
	return snap_to_tile(pos) - TILE_SIZE

static func drop_loot() -> void:
	pass


static func is_blocked(collider: RayCast2D) -> bool:
	collider.force_raycast_update()
	return collider.is_colliding()
