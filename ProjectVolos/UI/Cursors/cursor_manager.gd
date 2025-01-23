extends Node # cursor_manager.gd

const CURSOR_POINTER :Resource = preload(\
"res://ProjectVolos/UI/Cursors/cursor_pointer.png")
const GUANTLET_CURSOR :Resource = preload(\
"res://ProjectVolos/UI/Cursors/guantlet_cursor.png")
const SWORD_CURSOR :Resource = preload(\
"res://ProjectVolos/UI/Cursors/sword_cursor.png")
const SWORD_CURSOR_PRESSED :Resource  = preload(\
"res://ProjectVolos/UI/Cursors/sword_cursor_pressed.png")
const CURSOR = preload(\
"res://ProjectVolos/UI/Cursors/cursor.png")

# See [https://docs.godotengine.org/en/stable/classes/class_input.html#enum-input-cursorshape]
func _ready()->void:
	Input.set_custom_mouse_cursor(SWORD_CURSOR, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(GUANTLET_CURSOR, Input.CURSOR_POINTING_HAND)
