extends Node

@export var left_mask: Control
@export var right_mask: Control
@export var camera: Camera2D

@export var animation_speed: float = 1
@export var zoom_amount: CurveTexture
@export var split_amount: float

@export var loading_animation: AnimatedSprite2D

var time: float
var split: bool = false

func split_buttons():
	left_mask.visible = true
	right_mask.visible = true
	time = 0
	split = true

func _process(delta):
	if split and time < 0.2:
		time = time + delta / 10
		camera.zoom = Vector2(zoom_amount.curve.sample(time * animation_speed), zoom_amount.curve.sample(time * animation_speed))
		var start_pos = Vector2(left_mask.position.x, right_mask.position.x)
		if time > 0.1:
			left_mask.position.x = lerp(start_pos.x, -split_amount - 130, (time - 0.1) * animation_speed / 10)
			right_mask.position.x = lerp(start_pos.y, split_amount + 800, (time - 0.1) * animation_speed / 10)
	elif time >= 0.2 and time < 0.5:
		split = false
		left_mask.get_parent().visible = false
		time = time + delta / 10
		if !loading_animation.is_playing():
			loading_animation.play("Loading")
		loading_animation.modulate.a = lerp(0.0, 1.0, (time - 0.3) * 5)
