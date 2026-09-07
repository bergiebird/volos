extends Label
class_name UiTutorialControls

@onready var unpressed: Font = preload("res://Clep&Kog/UI/fonts_dont_move/Enter_Input_Dark.ttf")
@onready var pressed: Font = preload("res://Clep&Kog/UI/fonts_dont_move/Enter_Input_Dark_Pressed.ttf")
@onready var pushed: bool = false



func _on_second_timer_timeout() -> void:
	if pushed:
		pushed = false
		add_theme_font_override(&"font", pressed)
	else:
		pushed = true
		add_theme_font_override(&"font", unpressed)
