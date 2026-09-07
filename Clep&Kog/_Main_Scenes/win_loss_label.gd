extends Label
class_name WinLossLabel


var has_won: bool = false


func _ready() -> void:
	Signalton.level_complete.connect(winner)
	Signalton.level_lost.connect(loser)


func winner() -> void:
	visible = true
	text = "Certified \n Winner"
	scale = Vector2(1.0,1.0)


func loser() -> void:
	if !visible:
		visible = true
	elif has_won or scale >= Vector2(1.0,1.0):
		return
	else:
		scale += Vector2(0.1,0.1)
