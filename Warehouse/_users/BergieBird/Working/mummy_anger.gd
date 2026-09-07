extends TextureProgressBar
class_name MummyAnger

func _ready() -> void:
	Signalton.mummy_is_rebuilding.connect(add_value)
	Signalton.speed_up.connect(add_value)
	value = 0.0


func add_value() -> void:
	var tween_progress: Tween = create_tween()
	tween_progress.tween_property(self, ^'value', value + 1, 1.44)
