@icon("res://Warehouse/Icons/node/icon_audio.png")
extends AudioStreamPlayer # music_box.gd
const SONG_LENGTH: int = 90
@export var shhhh: bool = false



func _ready() -> void:
	fade_in()
	if shhhh:
		playing = false

func _on_finished() -> void:
	evaluate_song_stats()
	loop()

func loop(coming_from_finished_signal: bool = true, reduce_time_by: int = 30) -> void:
	var current_time: int = 0
	if coming_from_finished_signal:
		current_time = SONG_LENGTH
	else:
		stop()
		current_time = int(get_playback_position())
	current_time -= reduce_time_by
	play(current_time)
	if not is_playing():
		print('play did not work')

func evaluate_song_stats() -> void:
	print(get_playback_position())

func fade_in() -> void:
	volume_db -= 5
	lerp(volume_db, 0.0, 1.0)
