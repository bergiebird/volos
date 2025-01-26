@icon("res://Warehouse/_users/BergieBird/Working/resources/kog.png") extends Area2D
const CELL_SIZE: int = 16
@export var charge_distance: int = 6
var direction: Vector2
var is_already_moving: bool = false
var charging: bool = false
@onready var north_collider: Area2D = %NorthCollider
@onready var south_collider: Area2D = %SouthCollider
@onready var west_collider: Area2D = %WestCollider
@onready var east_collider: Area2D = %EastCollider

func _physics_process(delta: float):
	if can_do(): kontrols(delta)

func can_do() -> bool:
	if is_already_moving: return false
	if charging: return false
	return true

func kontrols(_delta) -> void:
	if Input.is_action_just_pressed("kog_charge"):
		process_movement(direction, true)
	elif Input.is_action_just_pressed("kog_right"):
		process_movement(Vector2.RIGHT)
	elif Input.is_action_just_pressed("kog_left"):
		process_movement(Vector2.LEFT)
	elif Input.is_action_just_pressed("kog_down"):
		process_movement(Vector2.DOWN)
	elif Input.is_action_just_pressed("kog_up"):
		process_movement(Vector2.UP)

func process_movement(new_direction: Vector2, is_charge: bool = false) -> void:
	if is_charge:
		charging = true
		Signalton.charge_started.emit()
		for unit in charge_distance:
			await move_once(new_direction)
		await get_tree().create_timer(.5).timeout
		snap_to_tile()
		await get_tree().create_timer(.5).timeout
		charging = false
		is_already_moving = false
		Signalton.charge_ended.emit()
	else:
		move_once(new_direction)

func move_once(new_direction: Vector2) -> void:
	var target_position: Vector2 = position + new_direction * CELL_SIZE
	var cooldown = 0.1
	direction = new_direction
	if cant_move_there():
		return
	is_already_moving = true
	if charging:
		create_tween().tween_property(self, "position", target_position, 0.1).set_trans(Tween.TRANS_SINE)
		cooldown = 0.05
		await get_tree().create_timer(cooldown).timeout
	else:
		position = target_position
		await get_tree().create_timer(cooldown).timeout
		is_already_moving = false

func cant_move_there():
	match direction:
		Vector2.UP: return north_collider.has_overlapping_bodies()
		Vector2.RIGHT: return east_collider.has_overlapping_bodies()
		Vector2.DOWN: return south_collider.has_overlapping_bodies()
		Vector2.LEFT: return west_collider.has_overlapping_bodies()
	return false

func snap_to_tile():
	position = round(position / 16) * 16
