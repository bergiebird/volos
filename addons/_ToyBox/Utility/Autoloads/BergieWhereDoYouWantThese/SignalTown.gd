extends Node #SignalTown.gd
## A Global Signal Bus for Assorted Gametypes. Feel free to add/comment out any signals as they as they aren't being used!


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
