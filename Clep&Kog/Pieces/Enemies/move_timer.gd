extends Timer
class_name MurderlingMoveTimer


func _ready() -> void:
	Signalton.mummy_is_rebuilding.connect(_speed_up)
	Signalton.speed_up.connect(_speed_up)


func _speed_up() -> void:
	if wait_time >= 0.5:
		wait_time -= 0.1
