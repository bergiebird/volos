@icon("res://addons/_ToyBox/Icons/color/icon_weapon.png")
class_name TheBoar # boar.gd
extends TileBasedCharacter

@onready var focus: FocusTile = %Focus

var score: int

#func _process(delta: float) -> void:
	#if Input.is_action_pressed("ui_right"):
		#position = focus.global_position


func _on_area_entered(character: TileBasedEntity) -> void:
	if can_kill and character.is_destroyable and !character.is_pickedup and !is_pickedup:
		kill(character)
		score += 1
		printt("Score:", score)
	else:
		printt("Why. Won't. You. Die?!")
