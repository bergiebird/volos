@icon("res://gold.png")
extends Area2D
@export var gold_worth :int = 1
@onready var sfx_pickup :AudioStreamPlayer2D = %SfxPickup
@onready var despawn :Timer = %Despawn

func _ready()->void:
	snap_to_tile()

func _on_area_entered(area :Area2D)->void:
	if area.name == 'Klep':
		Signalton.add_to_score.emit(gold_worth)
		_disappear()

func _disappear()->void:
	sfx_pickup.play()
	despawn.start()
	await despawn.timeout
	queue_free()

func snap_to_tile()->void:
	position = round(position / 16) * 16
