@icon("res://addons/_ToyBox/Icons/node_2D/icon_character.png")
class_name TileBasedCharacter
extends TileBasedEntity #tile_based_character.gd : Promoted a handful of edge_case scripts
@export var can_move:bool= true
@export var can_kill: bool= false
@export var max_range := 500
@export var move_rate := 5
@export var initial_direction :Vector2 = Vector2.RIGHT
@onready var ray :RayCast2D = $RayCast2D
var current_direction :Vector2
var moving :bool = false
var tween :Tween

func _unhandled_input(event :InputEvent)->void:
	if moving:
		return
	if not can_move:
		return
	if event.is_action_pressed("charge"):
		move_tiles(initial_direction, max_range)
		can_move = false

func kill(this_thing :TileBasedEntity)->void:
	if can_kill:
		SignalTown.who_killed_what.emit(this_thing, self)
		NodeRemover.remove(this_thing)

func move_tiles(direction :Vector2, tiles :int)->void:
	printt('unused variable, tiles: ', tiles, self.name)
	update_current(direction)
	tweenies(direction)

func update_current(direction :Vector2)->void:
	if current_direction != direction:
		current_direction = direction
		SignalTown.change_animated_direction.emit(current_direction, self)
		ray.target_position = direction * tile_size * 1.2
		ray.force_raycast_update()

func tweenies(direction :Vector2)->void:
	if ray.is_colliding() and tween:
		await tween.finished
		tween.kill()
	for i in range(max_range):
		update_current(direction)
		if ray.is_colliding():
			await tween.finished
			tween.kill()
		tween = create_tween()
		moving = true
		tween.tween_property(self, "position",
				position + direction * tile_size,
				1.0/move_rate).set_trans(Tween.TRANS_SINE)
		await tween.finished
		moving = false
