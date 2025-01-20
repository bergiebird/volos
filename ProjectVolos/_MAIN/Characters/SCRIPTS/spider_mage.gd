@icon("res://addons/_ToyBox/Icons/node/icon_character.png")
class_name SpiderMage
extends TileBasedEntity

@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var focus: FocusTile = %Focus
var is_selected: bool = false
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		global_position = focus.global_position
func play_vfx():
	pass
func play_sfx():
	pass
func play_effects():
	play_vfx()
	play_sfx()
func _on_send_north_area_exited(area: Area2D) -> void:
	play_effects()
func _on_send_right_area_exited(area: Area2D) -> void:
	play_effects()
func _on_send_south_area_exited(area: Area2D) -> void:
	play_effects()
func _on_send_left_area_exited(area: Area2D) -> void:
	play_effects()
