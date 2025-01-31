extends Label
var has_won :bool = false


func _ready()->void:
	Signalton.level_complete.connect(winner)
	Signalton.level_lost.connect(loser)


func winner()->void:
	visible = true
	text = "Certified \n Winner"
	scale = Vector2(1.6,1.6)

func loser()->void:
	if visible == false:
		visible = true
		return
	if has_won:
		return
	scale += Vector2(0.1,0.1)
