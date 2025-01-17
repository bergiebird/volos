extends MiniOptionsMenu # mini_options_menu_with_reset.gd

func _on_reset_game_control_reset_confirmed():
	GlobalState.reset()
