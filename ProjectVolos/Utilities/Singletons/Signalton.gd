extends Node #Signalton.gd

signal who_killed_what(responsible: TileBasedEntity, target: TileBasedCharacter)
signal sfx_break(target :TileBasedCharacter)
signal add_to_score(by_how_much: int)
#signal change_animated_direction(direction, who)
signal charge_started()
signal charge_ended()
#signal character_died(character)
#signal item_collected(item: Node2D)
signal transition_camera_2d_requested(from: Camera2D, to: Camera2D, duration: float)
