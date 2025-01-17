class_name HealthBarPercentage
extends ProgressBar

@export var hp_stat: HealthStatistics


func _ready() -> void:
	update()
	hp_stat.connect(&"hp_changed", _on_hp_changed)
	hp_stat.connect(&"max_hp_changed", _on_max_hp_changed)
	hp_stat.connect(&"hp_0", _on_death)


func update():
	value = hp_stat.hp * 100 / hp_stat.max_hp



func _on_hp_changed(_diff): update()
func _on_max_hp_changed(_diff): update()
func _on_death(): update()

# test
#func _input(event: InputEvent) -> void:
	#if event.is_action("interact"):
		#hp_stat.damage(1)
