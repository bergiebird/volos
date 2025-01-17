extends CharacterBody2D
# tank_style_movement_template.gd
# Pressing Left/Right for rotation, then Up/Down for Moving Forwards and Backwards
# Based On https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0

func get_input():
# Best practice is to remove the 'ui' commands with custom input commands.
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
