extends AnimatedSprite2D


func vec_compare()->bool:
	var mouse_pos = get_global_mouse_position()
	var min_pos = global_position - Vector2(9,9)
	var max_pos = global_position + Vector2(9,9)
	return mouse_pos.x >= min_pos.x\
	   and mouse_pos.y >= min_pos.y\
	   and mouse_pos.x <= max_pos.x\
	   and mouse_pos.y <= max_pos.y
