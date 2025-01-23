extends Node #score_manager.gd

@onready var score = 0
@onready var score_label: RichTextLabel = %ScoreLabel

func _ready():
	SignalTown.who_killed_what.connect(parse_the_killing)

func parse_the_killing(culprit, victim):
	SignalTown.sfx_break.emit(victim)
	printt("parse_the_killing",culprit,victim)
	score +=1
	adjust_score_label(score)
	printt("score",score)


func adjust_score_label(value :int)->void:
	printt('unused variable, value: ', value, self.name)
	score_label.set_text(str("[hue][wave]Score: ", score, "[/wave][hue]"))
