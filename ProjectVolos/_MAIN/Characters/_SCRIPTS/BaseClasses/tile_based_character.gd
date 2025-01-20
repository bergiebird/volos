@icon("res://addons/_ToyBox/Icons/node_2D/icon_character.png")
class_name TileBasedCharacter
extends TileBasedEntity

# Promoted a handful of edge_case scripts

@export var can_charge:bool= true # if we don't want a character to move, we turn this to False
@export var can_kill: bool= false
@export var max_range := 500
@export var move_rate := 5
@export var initial_direction := Vector2.RIGHT
@onready var ray :RayCast2D = $RayCast2D
var moving :bool = false
var current_direction :Vector2
var tween :Tween


func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	if not can_charge:
		return
	if event.is_action_pressed("charge"):
		move_tiles(initial_direction, max_range)
		can_charge = false

# this character will get credit for killing the target, not sure a use case but here we are -V
func kill(this_thing: TileBasedEntity)->void:
	if !can_kill:
		return
	SignalTown.who_killed_what.emit(self, this_thing)
	NodeRemover.remove(this_thing)


func move_tiles(direction: Vector2, tiles: int)->void:
	update_current(direction)
	if ray.is_colliding() and tween:
		await tween.finished
		tween.kill()
	for m in range(max_range):
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

func update_current(direction)->void:
	current_direction = direction
	ray.target_position = current_direction * tile_size * 1.2
	ray.force_raycast_update()
