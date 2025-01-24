@icon("res://addons/_ToyBox/Icons/node/icon_reset.png")
class_name CounterClockwiseTurnTile
extends Area2D # counter_clock_turn.gd
#TODO: Would it be simpler to have this be within clockwise turn and just pass a bool that determines clock or counter?

@onready var label :Label = $CollisionShape2D/Label

func _ready()->void:
	if Engine.is_editor_hint:
		label.show()
	else:
		label.hide()

func _on_area_entered(move_cardinal :TileBasedEntity)->void:
	spin_target(move_cardinal)


func spin_target(target)->void:
	if !target.has_method("move_tiles"):
		return
	if target.is_pickedup:
		return
	var original_direction = target.current_direction
	var flipped_direction = original_direction.orthogonal()
	await target.tween.finished
	target.tween.kill()
	target.move_tiles(flipped_direction, 30)
