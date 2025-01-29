extends Node #Signalton.gd


@warning_ignore("unused_signal")
signal who_killed_what(responsible, target)

@warning_ignore("unused_signal")
signal sfx_break(target)


signal add_to_score(by_how_much :int)

#signal change_animated_direction(direction, who)
@warning_ignore("unused_signal")
signal charge_started()

@warning_ignore("unused_signal")
signal charge_ended()

#signal character_died(character)
#signal item_collected(item: Node2D)
@warning_ignore("unused_signal")
signal transition_camera_2d_requested(from: Camera2D, to: Camera2D, duration: float)

signal level_complete
