@icon("res://addons/_ToyBox/Icons/color/icon_weapon.png")
class_name Murderling # boar.gd
extends TileBasedCharacter

@onready var focus: FocusTile = %Focus


func _on_area_entered(character:TileBasedEntity)->void:
	if character.is_destroyable:
		kill(character)
	else:
		printt("Why. Won't. You. Die?!")
