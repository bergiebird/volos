class_name PF_MOVEMENT_MODULE
extends RefCounted # platformer_movement_module.gd


# WIP Module to take care of all 2D platform movement logic

static func jump(body: CharacterBody2D):
	if body is not CharacterBody2D: return
	body.velocity.y -= body.jump_force

static func move(body: CharacterBody2D, direction: float): # direction: Left = -1 Right = 1. No input = 0.0
	if body is not CharacterBody2D: return
	var target_velocity: float = direction * body.speed
	body.velocity.x = move_toward(body.velocity.x, target_velocity, body.acceleration)
	if body.anim: # if the body has an animated sprite. This assumes sprites are RIGHT FACING by default
		body.anim.play(&"move")
		if direction < 0: body.anim.flip_h = true
		elif direction > 0: body.anim.flip_h = false
