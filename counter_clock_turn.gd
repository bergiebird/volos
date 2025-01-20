class_name CounterClockwiseTurnTile
extends Area2D # counter_clock_turn.gd

@onready var label: Label = $CollisionShape2D/Label

func _ready() -> void:
	# Only show these tiles if we are in the Editor
	if Engine.is_editor_hint: label.show()
	else: label.hide()

# called when the MoveCardinal area is entered
func _on_area_entered(target: TileBasedEntity) -> void:
	spin_target(target)




func spin_target(target):
	if !target.has_method("move_tiles"): return
	var original_direction = target.current_direction
	var flipped_direction = original_direction.orthogonal()
	await target.tween.finished
	target.tween.kill()
	target.move_tiles(flipped_direction, 30)
