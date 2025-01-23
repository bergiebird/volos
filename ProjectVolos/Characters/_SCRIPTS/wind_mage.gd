@icon("res://addons/_ToyBox/Icons/node/icon_character.png")
class_name WindMage
extends TileBasedEntity #wind_mage.gd
@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var vfx_wind: CPUParticles2D = $VfxWind
@onready var focus: FocusTile = %Focus

#func _process(delta :float)->void:
	#if Input.is_action_pressed("ui_left"):
		#global_position = focus.global_position
