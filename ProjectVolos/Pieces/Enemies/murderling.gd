@icon("res://ProjectVolos/Pieces/Enemies/mummy.png")
extends Area2D #murderling.gd

var astar = AStarGrid2D.new()
var current_path: Array[Vector2i]
var walls: TileMapLayer
var kog :Node
var goblin :Node
var is_stunned = false
@onready var sfx_rebuild :AudioStreamPlayer2D = %SfxRebuild
@onready var sfx_stun :AudioStreamPlayer2D = %SfxStun
@onready var sfx_capture :AudioStreamPlayer2D = %SfxCapture
@onready var anim_sprite :AnimatedSprite2D = %AnimatedSprite2D
@onready var vfx_capture :GPUParticles2D = %VfxCapture
@onready var mask :Node = %Mask
var is_capturing :bool = false
var target_position
var count :int = 0
func _ready()->void:
	Signalton.mummy_is_rebuilding.connect(rebuild)
	Signalton.stun_mummy.connect(got_stunned)
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
	goblin = get_parent().get_node("Klep")
	current_path = astar.get_id_path(
		walls.local_to_map(global_position),
		walls.local_to_map(goblin.global_position)
	).slice(1)
	kog = get_parent().get_node("Kog")
	if goblin:
		goblin.gob_moved.connect(goblin_move)

func goblin_move()->void:
	goblin = get_parent().get_node("Klep")
	current_path = astar.get_id_path(
		walls.local_to_map(global_position),
		walls.local_to_map(goblin.global_position)
	).slice(1)

func move()->void:
	if current_path.size() <= 1 and not is_stunned:
		if not is_capturing:
			begin_capture()
		return
	if current_path.front() == null:
		return
	if is_stunned:
		if count <= 2:
			count += 1
			return
		is_stunned = false
		mask.visible = false
		return
	target_position = walls.map_to_local(current_path.pop_front()) - Vector2(8, 8)
	play_animation(target_position - global_position)
	global_position = target_position

func _on_move_timer_timeout() -> void:
	move()

func got_stunned()->void:
	mask.visible = true
	count = 1
	is_stunned = true
	if is_capturing:
		is_capturing = false
		Signalton.kog_save.emit()
		Signalton.speed_up.emit()
		count = 0

	anim_sprite.play('stun')
	sfx_stun.play()
	Signalton.speed_up.emit()

func rebuild()->void:
	mask.visible = true
	anim_sprite.play('capture')
	sfx_rebuild.play()
	await $MoveTimer.timeout
	mask.visible = false

func play_animation(direction)->void:
	anim_sprite.play('walk')
	if direction == Vector2(16,0):
		anim_sprite.flip_h = false
	elif direction == Vector2(-16,0):
		anim_sprite.flip_h = true

func begin_capture()->void:
	anim_sprite.play('capture')
	Signalton.initiate_capture.emit()
	is_capturing = true
	vfx_capture.position = target_position
	vfx_capture.emitting = true
	mask.visible = true
	await get_tree().create_timer(1).timeout
	if is_capturing and not is_stunned:
		anim_sprite.play('pharoah')
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	await get_tree().create_timer(1).timeout
	if is_stunned:
		return
	finish_capturing()

func finish_capturing()->void:
	if is_capturing:
		Signalton.level_lost.emit()
