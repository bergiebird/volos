extends CharacterBody2D

@export var ground_velocity = 300.0
@export var jump_velocity = -400.0
var has_reached_hold_time = false
var max_hold_time =0.5

# Create a timer node, call it MaxHoldTimer. Right click it and give it a unique name.

func _physics_process(delta :float)->void:
	_gravity_and_reset(delta)
	_jump_hold(delta)
	_figure_out_direction()
	move_and_slide()
	print()

func _on_max_hold_timeout()->void:
	has_reached_hold_time = true

func _gravity_and_reset(delta)->void:
	if not is_on_floor(): velocity += get_gravity() * delta
	else:                 has_reached_hold_time = false

func are_we_in_hold_time()->bool:
	if not has_reached_hold_time:
		if Input.is_action_just_pressed("jump"):
			return true
	return false

func _jump_hold(delta)->void:
	if are_we_in_hold_time():
		velocity.y = jump_velocity

func _figure_out_direction()->void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * ground_velocity
	else:
		velocity.x = move_toward(velocity.x, 0, ground_velocity)
