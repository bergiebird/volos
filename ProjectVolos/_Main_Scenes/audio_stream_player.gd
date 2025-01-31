extends Node

@onready var capture = %NonCapture
@onready var game_over = %NonGameOver
@onready var victory = %NonVictory

func _ready()->void:
	Signalton.level_complete.connect(play_you_win)
	Signalton.initiate_capture.connect(play_capture_sfx)
	Signalton.kog_save.connect(end_sfx)
	Signalton.level_lost.connect(play_game_over)

func play_capture_sfx()->void:
	capture.play()

func end_sfx()->void:
	capture.stop()

func play_game_over()->void:
	game_over.play()

func play_you_win()->void:
	victory.play()
