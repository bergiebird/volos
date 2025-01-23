extends LevelListManager #level_list_state_manager.gd

func set_current_level_id(value :int)->void:
	super.set_current_level_id(value)
	GameState.level_reached(value)

func get_current_level_id()->int:
	if force_level == -1:
		return GameState.get_current_level_id()
	else:
		return force_level

func _advance_level():
	super._advance_level()
	GameState.set_current_level_id(get_current_level_id())
