@icon("res://addons/_ToyBox/Icons/node/icon_reset.png")
class_name ClockwiseTurnTile
extends Area2D # clockwise_turn.gd
# Give the unit a 180 spin
@onready var label: Label = $CollisionShape2D/Label


func _ready() -> void:
	if Engine.is_editor_hint:
		label.show()
	else:
		label.hide()

func _on_area_entered(move_cardinal: TileBasedEntity) -> void:
	spin_target(move_cardinal)

func spin_target(move_cardinal: TileBasedEntity) -> void:
	if !move_cardinal.has_method("move_tiles"):
		return
	if move_cardinal.is_pickedup:
		return
	var original_direction = move_cardinal.current_direction
	var flipped_direction = -original_direction.orthogonal()
	await move_cardinal.tween.finished
	move_cardinal.tween.kill()
	move_cardinal.move_tiles(flipped_direction, 30)
