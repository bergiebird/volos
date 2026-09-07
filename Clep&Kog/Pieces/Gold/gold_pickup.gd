@icon("uid://dnq8gsyyjvhxv")
extends Area2D
class_name Gold

@export var gold_worth: int = 1
@export var sfx_pickup: AudioStreamPlayer2D
@export var despawn_timer: Timer
@export var light: PointLight2D
var is_in_open_on_start: bool = true


func _ready() -> void:
	if is_in_open_on_start:
		Levelton.log_this_has_gold_cargo()
	position = L.snap_to_tile(position)
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is Clep:
		Signalton.emit_add_to_score(gold_worth)
		light.visible = false
		sfx_pickup.play()
		despawn_timer.start()
		await despawn_timer.timeout
		queue_free()
