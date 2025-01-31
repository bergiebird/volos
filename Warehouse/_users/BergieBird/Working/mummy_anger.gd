extends TextureProgressBar

func _ready()->void:
	Signalton.mummy_is_rebuilding.connect(add_value)
	Signalton.speed_up.connect(add_value)


func add_value()->void:
	value += 1
