@icon("res://addons/_ToyBox/Icons/color/icon_weapon.png")
class_name TheBoar # boar.gd
extends TileBasedCharacter

@onready var focus: FocusTile = %Focus

func _on_area_entered(character: TileBasedEntity) -> void:
	if can_kill and character.is_destroyable and !character.is_pickedup and !is_pickedup:
		SignalTown.who_killed_what.emit(self,character)
		kill(character)
	else:
		printt("Why. Won't. You. Die?!")





#func _process(delta: float) -> void:
	#if Input.is_action_pressed("ui_right"):
		#position = focus.global_position
