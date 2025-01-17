@icon("res://addons/_ToyBox/Icons/control/icon_stat.png")
class_name InputDisplayLabel
extends Label # input_display_label.gd


@onready var action_names := AppSettings.get_action_names()

func _input(event: InputEvent) -> void: set_text(_get_inputs_as_string())

func _process(_delta):
	if not Input.is_anything_pressed(): set_text("")
	# This was the previous implementation, commented out for posterity, -v
	#if Input.is_anything_pressed():
		#text = _get_inputs_as_string()
	#else:
		#text = ""

func _get_inputs_as_string():
	var all_inputs: String = ""
	var is_first: bool = true

	for action_name in action_names:
			if Input.is_action_pressed(action_name):
				if is_first:
					is_first = false
					all_inputs += action_name

				else: all_inputs += " + " + action_name
	return all_inputs
