extends Label
class_name Score

var saved_score: int = 0


func _ready() -> void:
	Signalton.add_to_score.connect(increase_label_text_by)
	increase_label_text_by()


func increase_label_text_by(number: int=0) -> void:
	saved_score += number
	text = str(saved_score)
	if saved_score >= 25:
		Signalton.emit_enough_treasure_collected()
