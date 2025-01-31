extends Label

@onready var unpressed = preload("res://ProjectVolos/UI/fonts_dont_move/Enter_Input_Dark.ttf")
@onready var pressed = preload("res://ProjectVolos/UI/fonts_dont_move/Enter_Input_Dark_Pressed.ttf")
@onready var pushed :bool = false



func _on_second_timer_timeout() -> void:
	if pushed:
		pushed = false
		add_theme_font_override("font", pressed)
	else:
		pushed = true
		add_theme_font_override("font", unpressed)
