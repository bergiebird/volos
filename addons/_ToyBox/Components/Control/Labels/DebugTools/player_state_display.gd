@icon("res://addons/_ToyBox/Icons/control/icon_stat.png")
class_name PlayerStateDisplay
extends Label # player_state_display.gd
# Sets the label to the target state machine's current active state
@export var state_machine:LimboHSM
func _process(delta:float)->void:
	set_text(str(state_machine.get_active_state()))
