@icon("res://addons/_ToyBox/Icons/control/icon_stat.png")
class_name KeyStrokeDisplayLabel
extends Label # keystroke_display_lable.gd

# This label will display the Keystroke in a human-readable fashion wherever it is displayed.

func _input(event):
	if event is InputEventKey and event.pressed:
		event.set_echo(false)
		set_text(event.as_text())
