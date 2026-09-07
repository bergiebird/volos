@icon("uid://bgoabwt7gafwi")
extends Area2D
class_name ExitPortal


var level_can_end: bool = false
var opened: bool = false

@onready var sfx_opened: AudioStreamPlayer = $Opened


func _ready() -> void:
	Signalton.enough_treasure_collected.connect(open_the_gate)
	area_entered.connect(_on_area_entered)
	visible = opened


func _on_area_entered(area: Area2D) -> void:
	if area is Clep and level_can_end:
		await get_tree().create_timer(0.12).timeout
		Signalton.emit_level_complete()


func open_the_gate() -> void:
	if opened:
		return
	opened = true
	sfx_opened.play()
	level_can_end = true
	visible = true


func _on_audio_stream_player_finished() -> void:
	sfx_opened.queue_free()
