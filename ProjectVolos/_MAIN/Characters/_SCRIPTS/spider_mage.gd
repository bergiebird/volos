@icon("res://addons/_ToyBox/Icons/node/icon_character.png")
class_name SpiderMage
extends TileBasedEntity

# Bounces a runner in the opposite direction
@onready var focus: FocusTile = %Focus


#func _process(delta: float) -> void:
#	if Input.is_action_pressed("ui_up"):
#		global_position = focus.global_position


func _on_turn_around_area_entered(area: Area2D) -> void:
	SignalTown.web_entered.emit
