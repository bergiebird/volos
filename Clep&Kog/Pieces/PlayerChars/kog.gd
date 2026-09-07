@icon("res://Clep&Kog/Pieces/PlayerChars/kog.png")
extends Area2D
class_name Kog

signal kog_moved

static var self_ref: Kog

@export_range(2,6) var charge_distance: int = 3
@export var movement_cooldown: float = 0.12
@export var north_collider: RayCast2D
@export var south_collider: RayCast2D
@export var east_collider: RayCast2D
@export var west_collider: RayCast2D
@export var vfx_wall: GPUParticles2D
@export var anim: AnimatedSprite2D
@export var sfx_charge: AudioStreamPlayer2D
@export var sfx_wall: AudioStreamPlayer2D

var direction: Vector2 = Vector2.ZERO
var is_already_moving: bool = false
var charging: bool = false
var anim_dir: String = 'v'
var kog_to_rescue: bool = false
var kog_rescue_speed: float = 0.05



func _ready() -> void:
	self_ref = self
	charge_distance = charge_distance * L.CELL_LENGTH
	position = L.snap_to_tile(position)
	Signalton.kog_save.connect(func(): kog_to_rescue = false)
	Signalton.initiate_capture.connect(func(): kog_to_rescue = true)
	animation_play('idle')


func _unhandled_input(_event: InputEvent) -> void:
	if is_already_moving or charging:
		return
	if Input.is_action_just_pressed("kog_charge"):
		process_movement(direction, true)
	elif Input.is_action_just_pressed("kog_right"):
		process_movement(Vector2.RIGHT)
		anim.flip_h = false
	elif Input.is_action_just_pressed("kog_left"):
		process_movement(Vector2.LEFT)
		anim.flip_h = true
	elif Input.is_action_just_pressed("kog_down"):
		process_movement(Vector2.DOWN)
	elif Input.is_action_just_pressed("kog_up"):
		process_movement(Vector2.UP)


func process_movement(new_direction: Vector2, is_charge: bool = false) -> void:
	kog_moved.emit()
	direction = new_direction
	if is_charge:
		if direction == Vector2.ZERO:
			return
		charging = true
		#set_collision_mask_value(6, false)
		animation_play('charge')
		sfx_charge.play()
		for unit: int in charge_distance:
			if charging:
				await move_once(new_direction, 0.1)
		await get_tree().create_timer(movement_cooldown/2).timeout
		animation_play('idle')
		position = L.snap_to_tile(position)
		await get_tree().create_timer(movement_cooldown/2).timeout
		charging = false
		is_already_moving = false
	else:
		move_once(new_direction)

func move_once(new_direction: Vector2, step_amount: float = 1) -> void:
	var target_position: Vector2 = position + new_direction * L.CELL_LENGTH * step_amount
	var cooldown: float = movement_cooldown
	if kog_to_rescue:
		cooldown = kog_rescue_speed
	if cant_move_there():
		if charging:
			charging = false
			cooldown = 1
			if kog_to_rescue:
				cooldown = 0.1
			sfx_wall.play()
			vfx_wall.position = Vector2(8, 8) + direction * L.CELL_LENGTH / 2
			match direction:
				Vector2.UP:
					vfx_wall.rotation_degrees = 180
				Vector2.RIGHT:
					vfx_wall.rotation_degrees = 270
				Vector2.DOWN:
					vfx_wall.rotation_degrees = 0
				Vector2.LEFT:
					vfx_wall.rotation_degrees = 90
			vfx_wall.emitting = true
			position = L.snap_to_tile(position)
			animation_play('stun')
			await get_tree().create_timer(cooldown).timeout
		#	set_collision_mask_value(6, true)
			animation_play('idle')
		return
	is_already_moving = true
	if charging:
		position = target_position
		cooldown = 0.01
		await get_tree().create_timer(cooldown).timeout
	elif not cant_move_there():
		position = target_position
		await get_tree().create_timer(cooldown).timeout
		is_already_moving = false

func cant_move_there() -> bool:
	if charging:
		if has_overlapping_bodies():
			var names: Array[Node2D] = get_overlapping_bodies()
			for _name: Node2D in names:
				if _name.get_parent() is Murderling:
					Signalton.emit_stun_mummy(_name)
				return true
		else:
			return false
	animation_play('idle')
	match direction:
		Vector2.UP:
			return L.is_blocked(north_collider)
		Vector2.RIGHT:
			return L.is_blocked(east_collider)
		Vector2.DOWN:
			return L.is_blocked(south_collider)
		Vector2.LEFT:
			return L.is_blocked(west_collider)
		_:
			return false

func animation_play(type: String) -> void:
	match direction:
		Vector2.UP:    anim_dir = 'u'
		Vector2.RIGHT: anim_dir = 'v'
		Vector2.DOWN:  anim_dir = 'd'
		Vector2.LEFT:  anim_dir = 'v'
	anim.play(str(type, '_', anim_dir))
