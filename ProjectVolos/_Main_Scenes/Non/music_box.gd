@icon("res://addons/_ToyBox/Icons/node/icon_audio.png")
extends AudioStreamPlayer #music_box.gd
const SONG_LENGTH :int = 90
@export var shhhh :bool = false

func _ready()->void:
	# Vrood small tweak, adjust if we don't likey
	fade_in()
	if shhhh:
		playing = false

func _on_finished()->void:
	evaluate_song_stats()
	loop()

func loop(coming_from_finished_signal :bool=true, reduce_time_by :int=30)->void:
	var current_time :int = 0
	if coming_from_finished_signal:
		current_time = SONG_LENGTH
	else:
		stop()
		current_time = int(get_playback_position())
	current_time -= reduce_time_by
	play(current_time)
	if not is_playing():
		print('play did not work')

func evaluate_song_stats()->void:
	print(get_playback_position())

func fade_in()->void:
	var fade_in_rate: float = 0.5
	volume_db -= 5
	lerp(volume_db, 0.0, 1.0)

'''
Other scripts that want to interact with this node will most likely:
	 tell this node to stop playing:
		collect get_playback_position() before initiating stop()
'''
