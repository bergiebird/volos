@icon("res://Clep&Kog/Pieces/Enemies/mummy.png")
extends Area2D
class_name Murderling

@export var stun_wait_time: float = 1.5

var current_path: Array[Vector2i]
var walls: TileMapLayer
var goblin: Node
var is_stunned: bool
var is_capturing: bool
var target_position: Vector2
var count: int = 0
var difficulty: L.Difficulty

@export var nav: Nav
@export var stun_timer: Timer
@export var sfx_rebuild: AudioStreamPlayer2D
@export var sfx_stun: AudioStreamPlayer2D
@export var sfx_capture: AudioStreamPlayer2D
@export var anim_sprite: AnimatedSprite2D
@export var vfx_capture: GPUParticles2D
@export var move_timer: MurderlingMoveTimer
@export var static_mummy: StaticBody2D

func _ready() -> void:
	stun_timer.wait_time = stun_wait_time
	move_timer.timeout.connect(move)
	Signalton.mummy_is_rebuilding.connect(rebuild)
	Signalton.stun_mummy.connect(got_stunned)
	if difficulty:
		move_timer.wait_time = L.DIFFICULTY_TO_MOVE_TIME[difficulty]


func move() -> void:
	if nav.current_path.size() <= 2 and not is_stunned:
		if is_capturing:
			return
		else:
			begin_capture()

	if nav.current_path.front():
		if is_stunned:
			if count <= 2:
				count += 1
			else:
				is_stunned = false
		else:
			target_position = nav.walls.map_to_local(nav.current_path.pop_front()) - Vector2(8, 8)
			play_animation(target_position - global_position)
			global_position = target_position


func got_stunned(who: Node2D) -> void:
	if who != static_mummy:
		return
	count = 1
	is_stunned = true
	if is_capturing:
		is_capturing = false
		count = 0
		Signalton.emit_kog_save()
		vfx_capture.emitting = false
		vfx_capture.visible = false
	anim_sprite.play('stun')
	sfx_stun.play()


func rebuild() -> void:
	for body: Area2D in get_overlapping_areas():
		if body is BreakableWall:
			anim_sprite.play('capture')
			sfx_rebuild.play()


func play_animation(direction: Vector2) -> void:
	anim_sprite.play('walk')
	if direction == Vector2(16,0):
		anim_sprite.flip_h = false
	elif direction == Vector2(-16,0):
		anim_sprite.flip_h = true


func begin_capture() -> void:
	anim_sprite.play('capture')
	Signalton.emit_initiate_capture()
	is_capturing = true
	vfx_capture.visible = true
	vfx_capture.position = target_position
	vfx_capture.emitting = true
	await get_tree().create_timer(1).timeout
	if is_capturing and not is_stunned:
		anim_sprite.play('pharoah')
	for i: int in 9:
		await get_tree().create_timer(1).timeout
		if is_stunned:
			return
	if is_capturing and not is_stunned: # LOSE STATE
		Signalton.emit_level_lost()
