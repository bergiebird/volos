extends CharacterBody2D
# top_down_movement_template.gd
# 8 Direction Top Down Movement Script
# Based On https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html

@export var speed = 400

func get_input():
	# Best practice is to remove the 'ui' commands with custom input commands.
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
