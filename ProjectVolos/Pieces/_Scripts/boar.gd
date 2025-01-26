@icon("res://addons/_ToyBox/Icons/color/icon_weapon.png")
class_name TheBoar # boar.gd
extends TileBasedCharacter

@onready var focus :FocusTile = %Focus

func _ready()->void:
	Signalton.change_animated_direction.connect(_change_boar_direction)

func _on_area_entered(character :TileBasedEntity)->void:
	if can_kill and !is_pickedup:
		if character.is_destroyable and !character.is_pickedup:
			Signalton.who_killed_what.emit(self,character)
			kill(character)
		else:
			printt("Why. Won't. You. Die?!")
	else:
		printt("Why. Won't. You. Die?!")

func _change_boar_direction(direction)->void:
	pass


#func _process(_delta :float)->void:
	#if Input.is_action_pressed("ui_right"):
		#position = focus.global_position
