
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var jump_hold_time = 0.0
var max_hold_time =0.5


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		%MaxHold.start()
	elif Input.is_action_pressed("jump"):
		jump_hold_time += delta
		print(jump_hold_time)
	elif jump_hold_time > max_hold_time:
		pass
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
