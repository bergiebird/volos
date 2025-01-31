@icon("res://Warehouse/DemonicDungeonAssets/ExitGate.png")
extends Area2D
var level_can_end :bool = false

func _on_area_entered(area :Area2D)->void:
	if area.name == 'Klep' and level_can_end:
		print('level complete')
		Signalton.level_complete.emit()

func _ready()->void:
	Signalton.enough_treasure_collected.connect(open_the_gate)

func open_the_gate()->void:
	level_can_end = true
	visible = true
