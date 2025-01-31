extends Timer



func _ready()->void:
	Signalton.mummy_is_rebuilding.connect(_speed_up)
	Signalton.speed_up.connect(_speed_up)

func _speed_up()->void:
	if wait_time >= 0.5:
		print(wait_time)
		wait_time -= 0.1
