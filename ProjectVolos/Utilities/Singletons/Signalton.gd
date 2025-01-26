extends Node #Signalton.gd
## A Global Signal Bus for Assorted Gametypes.
## Feel free to add/comment out any signals as they as they aren't being used!

signal who_killed_what(responsible: TileBasedEntity, target: TileBasedCharacter)
signal sfx_break(target :TileBasedCharacter)
signal add_to_score(by_how_much: int) #TODO: Display score in bottom right of screen on UI
signal twister_entered # see twister.gd
signal web_entered # see spider_mage.gd
signal spinner_activated # spin_mage.gd
signal change_animated_direction(direction, who) # TODO: Use for Animation Player
signal charge_started()
signal charge_ended()


signal cant_go_north()
signal cant_go_south()
signal cant_go_west()
signal cant_go_east()


















































@warning_ignore("unused_signal")
#region "TurnBased Combat"
signal begin_turn(character)
signal end_turn(character)
signal character_died(character)
signal combat_action_executed(action, executor, target)
#endregion

#region "Item Collection"
signal item_collected(item: Node2D, collector: Node2D)

#endregion

#region "Camera Transitions"
signal transition_camera_2d_requested(from: Camera2D, to: Camera2D, duration: float)

#endregion
