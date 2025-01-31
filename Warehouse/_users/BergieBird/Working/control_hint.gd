extends Label
@export var input_map_string :String
var flip :bool = true
var count :int = 0
@onready var unpressed = preload("res://ProjectVolos/UI/fonts_dont_move/Enter_Input_Dark.ttf")
@onready var pressed = preload("res://ProjectVolos/UI/fonts_dont_move/Enter_Input_Dark_Pressed.ttf")
var was_pressed :bool = false

func _ready()->void:
	text = name
	%OneSecond.timeout.connect(_on_one_second_timeout)

func _input(event)->void:
	if event.is_action_released(input_map_string) and not was_pressed:
		was_pressed = true
		$Unrect1.queue_free()
		$Unrect2.queue_free()
		add_theme_font_override("font", pressed)
		count+=1

func _on_one_second_timeout()->void:
	if count > 0:
		count +=1
		if count > 3:
			queue_free()
