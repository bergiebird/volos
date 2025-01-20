@icon("res://addons/_ToyBox/Icons/node/icon_reset.png")
class_name MoverCardinalTile
extends Area2D
@export var direction:Vector2 = Vector2.UP
@onready var label:Label = $CollisionShape2D/Label

func _ready()->void:
	if Engine.is_editor_hint:
		label.show()
	else:
		label.hide()

func _on_area_entered(move_cardinal :TileBasedEntity)->void:
	stop_target(move_cardinal)

func stop_target(move_cardinal :TileBasedEntity)->void:
	if !move_cardinal.has_method("move_tiles"):
		return
	if !move_cardinal.tween:
		return
	await move_cardinal.tween.finished
	move_cardinal.tween.kill()
	move_cardinal.move_tiles(direction, 30)
