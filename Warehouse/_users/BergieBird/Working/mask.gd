@icon("res://Warehouse/Icons/control/icon_card.png")
extends Node2D
class_name NormalMask


@export var will_this_blink: bool = true
@export var timer: Timer


func _ready() -> void:
	if will_this_blink:
		timer.start()


func _on_timer_timeout() -> void:
	visible = !visible
