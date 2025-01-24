extends Node

@export var left_mask: Control
@export var right_mask: Control
@export var camera: Camera2D

@export var animation_speed: float = 1
@export var zoom_amount: CurveTexture
@export var split_amount: float

var time: float
var split: bool = false

func split_buttons():
	left_mask.visible = true
	right_mask.visible = true
	time = 0
	split = true

func _process(delta):
	if split and time < 1:
		time = time + delta / 10
		camera.zoom = Vector2(zoom_amount.curve.sample(time * animation_speed), zoom_amount.curve.sample(time * animation_speed))
		var start_pos = Vector2(left_mask.position.x, right_mask.position.x)
		if time > 0.2:
			left_mask.position.x = lerp(start_pos.x, -split_amount, (time - 0.2) * animation_speed / 10)
			right_mask.position.x = lerp(start_pos.y, split_amount + 800, (time - 0.2) * animation_speed / 10)
