extends TextureProgressBar
class_name TreasureProgress

var current_value: int


func _ready() -> void:
	Signalton.add_to_score.connect(add_to_progress)
	(func():max_value = Levelton.get_max_score()).call_deferred()

func add_to_progress(number: int) -> void:
	var tween: Tween = create_tween()
	current_value += number
	await tween.tween_property(self, ^'value', value + number, 0.144).finished
	value = current_value
	if current_value >= max_value:
		Signalton.enough_treasure_collected.emit()
