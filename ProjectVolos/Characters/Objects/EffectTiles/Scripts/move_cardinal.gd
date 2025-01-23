@icon("res://addons/_ToyBox/Icons/node/icon_reset.png")
class_name MoverCardinalTile
extends Area2D #move_cardinal.gd
@export var direction :Vector2 = Vector2.UP
@onready var label :Label = $CollisionShape2D/Label
#NOTE: I'm noticing a lot of repeated scripts here, we could definitely combine?
func _ready()->void:
	if Engine.is_editor_hint:
		label.show()
	else:
		label.hide()

func _on_area_entered(move_cardinal :TileBasedCharacter)->void:
	stop_target(move_cardinal)

func stop_target(target :TileBasedCharacter)->void:
	if !target.has_method("move_tiles"):
		return
	if !target.tween:
		return
	if target.is_pickedup:
		return
	await target.tween.finished
	target.tween.kill()
	target.move_tiles(direction, 30)
