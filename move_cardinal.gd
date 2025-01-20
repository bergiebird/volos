class_name MoveTile
extends Area2D


@export var direction := Vector2.UP
@onready var label: Label = $CollisionShape2D/Label


func _ready() -> void:
	# Only show these tiles if we are in the Editor
	if Engine.is_editor_hint: label.show()
	else: label.hide()

# called when the MoveCardinal area is entered
func _on_area_entered(target: TileBasedCharacter) -> void:
	target.move_to_next_tile(direction)
	#stop_target(target)


func stop_target(target: Area2D):
	#if target.tween:
	#	await target.tween.stop
	#	target.tween.kill()
	pass
