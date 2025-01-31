extends TextureProgressBar


func _ready() -> void:
	Signalton.add_to_score.connect(add_to_progress)

func add_to_progress(number)->void:
	value += number
	if value >= 25:
		Signalton.enough_treasure_collected.emit()
