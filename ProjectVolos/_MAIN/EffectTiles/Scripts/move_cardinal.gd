@icon("res://addons/_ToyBox/Icons/node/icon_reset.png")
class_name MoverCardinalTile
extends Area2D


@export var direction := Vector2.UP
@onready var label: Label = $CollisionShape2D/Label


func _ready() -> void:
	# Only show these tiles if we are in the Editor
	if Engine.is_editor_hint: label.show()
	else: label.hide()

# called when the MoveCardinal area is entered
func _on_area_entered(target: TileBasedEntity) -> void:
	stop_target(target)


func stop_target(target):
	if !target.has_method("move_tiles"): return
	if !target.tween: return
	await target.tween.finished
	target.tween.kill()
	target.move_tiles(direction, 30)
