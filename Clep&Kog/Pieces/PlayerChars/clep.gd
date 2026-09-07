@icon("res://Clep&Kog/Pieces/PlayerChars/goblin.png")
extends Area2D
class_name Clep

signal has_moved
static var self_ref: Clep

@export var movement_cooldown: float = 0.07

var is_colored_while_getting_captured: bool = false
var direction: Vector2
var moving: bool = false
var is_captured: bool = false

@export var north_collider: RayCast2D
@export var south_collider: RayCast2D
@export var east_collider: RayCast2D
@export var west_collider: RayCast2D
@export var treasure_collider: CollisionShape2D
@export var anim_sprite: AnimatedSprite2D
@export var timer_danger: Timer


func _ready() -> void:
	self_ref = self
	timer_danger.timeout.connect(_on_danger_timer_timeout)
	Signalton.initiate_capture.connect(getting_captured)
	Signalton.kog_save.connect(got_saved)
	position = L.snap_to_tile(position)


func _unhandled_input(_event: InputEvent) -> void:
	if moving or is_captured:
		return
	if Input.is_action_pressed(&"loot_right"):
		move_once(Vector2.RIGHT)
		anim_sprite.flip_h = false
	elif Input.is_action_pressed(&"loot_left"):
		move_once(Vector2.LEFT)
		anim_sprite.flip_h = true
	elif Input.is_action_pressed(&"loot_down"):
		move_once(Vector2.DOWN)
	elif Input.is_action_pressed(&"loot_up"):
		move_once(Vector2.UP)


func move_once(new_direction: Vector2) -> void:
	direction = new_direction
	if cant_move_there():
		return
	moving = true
	var target_position: Vector2 = position + new_direction * L.CELL_LENGTH
	position = target_position
	has_moved.emit()
	await get_tree().create_timer(movement_cooldown).timeout
	moving = false


func cant_move_there() -> bool:
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


func getting_captured() -> void:
	is_captured = true
	timer_danger.start()
	is_colored_while_getting_captured = false
	modulate = Color("ad4030")


func got_saved() -> void:
	is_captured = false
	timer_danger.stop()
	modulate = Color("ffffff")

func _on_danger_timer_timeout() -> void:
	if is_colored_while_getting_captured:
		modulate = Color("ad4030")
		is_colored_while_getting_captured = false
	else:
		modulate = Color("f6f2c3")
		is_colored_while_getting_captured = true
