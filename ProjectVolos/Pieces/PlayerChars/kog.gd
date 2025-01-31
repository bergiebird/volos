@icon("res://ProjectVolos/Pieces/PlayerChars/kog.png")
extends Area2D #kog.gd
const CELL_SIZE: int = 16
@export var charge_distance: int = 6
var direction: Vector2 = Vector2.ZERO
var is_already_moving: bool = false
var charging: bool = false
var anim_dir :String = 'v'
var flipped :bool = false
@onready var north_collider: Area2D = %NorthCollider
@onready var south_collider: Area2D = %SouthCollider
@onready var west_collider: Area2D = %WestCollider
@onready var east_collider: Area2D = %EastCollider
@onready var vfx_wall: GPUParticles2D = $VfxWall
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_charge: AudioStreamPlayer2D = %SfxCharge
@onready var sfx_wall: AudioStreamPlayer2D = %SfxWall
signal kog_moved
var kog_to_rescue :bool = false
var kog_rescue_speed :float = 0.05
var normal_cooldown :float = 0.1

func _physics_process(delta: float)->void:
	if can_do():
		kontrols(delta)

func _ready()->void:
	Signalton.kog_save.connect(rescue_over)
	Signalton.initiate_capture.connect(save_klep_now)
	animation_play('idle')

func rescue_over()->void:
	kog_to_rescue = false
func save_klep_now()->void:
	kog_to_rescue = true

func can_do()->bool:
	if is_already_moving: return false
	if charging: return false
	return true

func kontrols(_delta)->void:
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

func process_movement(new_direction: Vector2, is_charge: bool = false)->void:
	kog_moved.emit()
	direction = new_direction
	if is_charge:
		if direction == Vector2.ZERO:
			return
		charging = true
		set_collision_mask_value(2, false)
		animation_play('charge')
		sfx_charge.play()
		for unit in charge_distance * 10:
			if charging:
				await move_once(new_direction, 0.1)
		await get_tree().create_timer(.05).timeout
		animation_play('idle')
		snap_to_tile()
		await get_tree().create_timer(.45).timeout
		charging = false
		is_already_moving = false
	else:
		move_once(new_direction)

func move_once(new_direction: Vector2, step_amount: float = 1)->void:
	var target_position: Vector2 = position + new_direction * CELL_SIZE * step_amount
	var cooldown = normal_cooldown
	if kog_to_rescue:
		cooldown = kog_rescue_speed
	if cant_move_there():
		if charging:
			charging = false
			cooldown = 1
			if kog_to_rescue:
				cooldown = 0.1
			sfx_wall.play()
			vfx_wall.position = Vector2(8, 8) + direction * CELL_SIZE / 2
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
			snap_to_tile()
			animation_play('stun')
			await get_tree().create_timer(cooldown).timeout
			set_collision_mask_value(2, true)
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

func cant_move_there():
	if charging:
		if has_overlapping_bodies():
			var names = get_overlapping_bodies()
			for _name in names:
				if _name.name == 'StaticMummy':
					Signalton.stun_mummy.emit()
			return true
		else:
			return false
	animation_play('idle')
	match direction:
		Vector2.UP:
			return north_collider.has_overlapping_bodies()
		Vector2.RIGHT:
			return east_collider.has_overlapping_bodies()
		Vector2.DOWN:
			return south_collider.has_overlapping_bodies()
		Vector2.LEFT:
			return west_collider.has_overlapping_bodies()

func snap_to_tile():
	position = round(position / 16) * 16

func animation_play(type :String):
	match direction:
		Vector2.UP:
			anim_dir = 'u'
		Vector2.RIGHT:
			anim_dir ='v'
		Vector2.DOWN:
			anim_dir = 'd'
		Vector2.LEFT:
			anim_dir = 'v'
	anim.play(str(type, '_', anim_dir))
