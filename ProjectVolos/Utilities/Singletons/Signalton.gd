extends Node #Signalton.gd


signal add_to_score(by_how_much :int)

signal transition_camera_2d_requested(from: Camera2D, to: Camera2D, duration: float)

signal level_complete

signal speed_up()
signal stun_mummy()
signal mummy_is_rebuilding()
signal enough_treasure_collected()
signal update_anger()
signal initiate_capture()
signal kog_save()
signal level_lost()
