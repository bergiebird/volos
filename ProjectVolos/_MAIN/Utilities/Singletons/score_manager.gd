extends Node #score_manager.gd

@onready var score = 0

func _ready():
	SignalTown.who_killed_what.connect(parse_the_killing)

func parse_the_killing(responsible,target):
	SignalTown.sfx_break.emit(target)
	printt("parse_the_killing",responsible,target)
	score +=1
	printt("score",score)
