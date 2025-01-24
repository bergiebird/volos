xtends Control

func _on_ResetGameControl_reset_confirmed():
	GlobalState.reset()
	get_tree().quit()
