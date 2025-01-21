@icon("res://addons/_ToyBox/Icons/node/icon_audio.png")
extends AudioStreamPlayer
var reduce_seconds_by: int = 30
var new_time: int = 0
@export var shhhh = false

func _ready():
	if shhhh:
		playing = false
		set_process(false)

func evaluate_song_position(delta):
	print(get_playback_position())


func _on_finished()->void:
	print(get_playback_position())
	set_process(false)
	loop(true)

func loop(coming_from_finished_signal:bool = false):
	var current_time = 90
	if coming_from_finished_signal:
		pass
	else:
		current_time = int(get_playback_position())

	await play()
	if is_playing():
		set_process(true)
	else:
		print('seek did not work')
