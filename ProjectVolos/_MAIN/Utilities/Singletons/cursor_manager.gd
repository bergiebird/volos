extends Node
# cursor_manager.gd

const CURSOR_POINTER = preload("res://ProjectVolos/Vrood/UI_Cutup/cursor_pointer.png")
const GUANTLET_CURSOR = preload("res://ProjectVolos/Vrood/UI_Cutup/guantlet_cursor.png")
const SWORD_CURSOR = preload("res://ProjectVolos/Vrood/UI_Cutup/sword_cursor.png")
const SWORD_CURSOR_PRESSED = preload("res://ProjectVolos/Vrood/UI_Cutup/sword_cursor_pressed.png")


# See [https://docs.godotengine.org/en/stable/classes/class_input.html#enum-input-cursorshape]
func _ready()->void:
	Input.set_custom_mouse_cursor(SWORD_CURSOR, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(GUANTLET_CURSOR, Input.CURSOR_POINTING_HAND)
