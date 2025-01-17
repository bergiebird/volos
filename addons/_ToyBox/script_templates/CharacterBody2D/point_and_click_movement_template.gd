extends CharacterBody2D
# point_and_click_movement_template.gd
# Based on https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html

@export var speed = 400

var target = position

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action_pressed(&"LMB"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()
