@icon("res://addons/_ToyBox/Icons/control/icon_card.png")
extends Node2D

@onready var mask = $ColorRect
@onready var timer = $Timer
@export var will_this_blink = true

func _ready():
	if will_this_blink:
		timer.start()

func _on_timer_timeout():
	mask.visible = !mask.visible
