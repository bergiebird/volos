@icon("res://ProjectVolos/Pieces/PlayerChars/goblin.png")
extends Area2D

const CELL_SIZE :int = 16
@export var charge_distance :int = 6
var direction :Vector2
var is_already_moving :bool = false
@onready var north_collider :Area2D = %NorthCollider
@onready var south_collider :Area2D = %SouthCollider
@onready var west_collider :Area2D = %WestCollider
@onready var east_collider :Area2D = %EastCollider
@onready var treasure_collider :CollisionShape2D = %TreasureCollider
@onready var anim_sprite :AnimatedSprite2D = %AnimatedSprite2D
@onready var timer :Timer = %DangerTimer
var is_captured :bool = false
signal gob_moved

func _ready()->void:
	Signalton.initiate_capture.connect(getting_captured)
	Signalton.kog_save.connect(got_saved)
	print(timer)

func _physics_process(delta: float)->void:
	if can_do():
		controls(delta)

func can_do()->bool:
	if is_already_moving:
		return false
	return true

func controls(_delta)->void:
	if is_captured:
		return
	if Input.is_action_just_pressed("loot_right"):
		move_once(Vector2.RIGHT)
		anim_sprite.flip_h = false
	elif Input.is_action_just_pressed("loot_left"):
		move_once(Vector2.LEFT)
		anim_sprite.flip_h = true
	elif Input.is_action_just_pressed("loot_down"):
		move_once(Vector2.DOWN)
	elif Input.is_action_just_pressed("loot_up"):
		move_once(Vector2.UP)

func move_once(new_direction: Vector2)->void:
	gob_moved.emit()
	var target_position: Vector2 = position + new_direction * CELL_SIZE
	var cooldown: float = 0.1
	direction = new_direction
	if cant_move_there():
		return
	is_already_moving = true
	position = target_position
	await get_tree().create_timer(cooldown).timeout
	is_already_moving = false

func cant_move_there()->bool:
	print(direction)
	match direction:
		Vector2.UP:
			return north_collider.has_overlapping_bodies()
		Vector2.RIGHT:
			return east_collider.has_overlapping_bodies()
		Vector2.DOWN:
			print(south_collider.get_overlapping_bodies())
			return south_collider.has_overlapping_bodies()
		Vector2.LEFT:
			return west_collider.has_overlapping_bodies()
	return false

func getting_captured()->void:
	is_captured = true
	timer.start()
	bol = false
	modulate = Color("ad4030")

func got_saved()->void:
	is_captured = false
	timer.stop()
	modulate = Color("ffffff")

var bol :bool = false
func _on_danger_timer_timeout() -> void:
	if bol:
		modulate = Color("ad4030")
		bol = false
	else:
		modulate = Color("f6f2c3")
		bol = true
