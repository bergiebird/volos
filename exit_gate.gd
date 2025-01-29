@icon("res://Warehouse/DemonicDungeonAssets/ExitGate.png")
extends Area2D

func _on_area_entered(area :Area2D)->void:
	if area.name == 'LootGoblin':
		Signalton.level_complete.emit()
