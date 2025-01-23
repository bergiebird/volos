@icon("res://addons/_ToyBox/Icons/node/icon_reset.png")
class_name ClockwiseTurnTile
extends Area2D # clockwise_turn.gd
# Give the unit a 180 spin
@onready var label :Label = $CollisionShape2D/Label


func _ready()->void:
	if Engine.is_editor_hint:
		label.show()
	else:
		label.hide()

func _on_area_entered(move_cardinal :TileBasedEntity)->void:
	spin_target(move_cardinal)

func spin_target(target :TileBasedEntity)->void:
	if !target.has_method("move_tiles"):
		return
	if target.is_pickedup:
		return
	var original_direction = target.current_direction
	var flipped_direction = -original_direction.orthogonal()
	await target.tween.finished
	target.tween.kill()
	target.move_tiles(flipped_direction, 30)
