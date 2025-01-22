extends Node #score_manager.gd

@onready var score = 0
@onready var score_label: RichTextLabel = %ScoreLabel

func _ready():
	SignalTown.who_killed_what.connect(parse_the_killing)

func parse_the_killing(responsible,target):
	SignalTown.sfx_break.emit(target)
	printt("parse_the_killing",responsible,target)
	score +=1
	adjust_score_label(score)
	printt("score",score)


func adjust_score_label(value: int)->void:
	score_label.set_text(str("[hue][wave]Score: ", score, "[/wave][hue]"))
