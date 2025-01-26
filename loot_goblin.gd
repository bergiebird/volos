@icon("res://ProjectVolos/Pieces/PlayerChars/loot_goblin.png") extends Area2D

const CELL_SIZE :int = 16
@export var charge_distance :int = 6
var direction :Vector2
var is_already_moving :bool = false
@onready var north_collider :Area2D = %NorthCollider
@onready var south_collider :Area2D = %SouthCollider
@onready var west_collider :Area2D = %WestCollider
@onready var east_collider :Area2D = %EastCollider

func _physics_process(delta :float):
	if can_do():
		controls(delta)

func can_do()->bool:
	if is_already_moving:
		return false
	return true

func controls(_delta)->void:
	if Input.is_action_just_pressed("loot_right"):
		move_once(Vector2.RIGHT)
	elif Input.is_action_just_pressed("loot_left"):
		move_once(Vector2.LEFT)
	elif Input.is_action_just_pressed("loot_down"):
		move_once(Vector2.DOWN)
	elif Input.is_action_just_pressed("loot_up"):
		move_once(Vector2.UP)

func move_once(new_direction :Vector2)->void:
	var target_position :Vector2 = position + new_direction * CELL_SIZE
	var cooldown :float = 0.1
	direction = new_direction
	if cant_move_there():
		print('north')
		return
	is_already_moving = true
	position = target_position
	await get_tree().create_timer(cooldown).timeout
	is_already_moving = false

func cant_move_there():
	match direction:
		Vector2.UP:
			return north_collider.has_overlapping_bodies()
		Vector2.RIGHT:
			return east_collider.has_overlapping_bodies()
		Vector2.DOWN:
			return south_collider.has_overlapping_bodies()
		Vector2.LEFT:
			return west_collider.has_overlapping_bodies()
	return false
