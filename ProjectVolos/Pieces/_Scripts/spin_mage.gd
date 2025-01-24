@icon("res://addons/_ToyBox/Icons/node/icon_character.png")
class_name SpinMage
extends TileBasedEntity #spin_mage.gd

# Sends a Runner Clockwise
@onready var focus :FocusTile = %Focus

func _on_clockwise_turn_area_entered(area :Area2D)->void:
	SignalTown.spinner_activated.emit
