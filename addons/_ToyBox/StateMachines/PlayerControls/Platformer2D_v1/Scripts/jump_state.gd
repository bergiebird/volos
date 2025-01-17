extends LimboState #jump_state.gd


var player: CharacterBody2D
var current_velocity: float

func _setup()->void:
	pass

func _enter()->void:
	player = get_parent().player
	PF_MOVEMENT_MODULE.jump(player)
	if player.debug: print("Jump")

func _exit()->void:
	pass

func _update(delta:float)->void:
	var direction:float = Input.get_axis("move_left", "move_right")
	var target_velocity:float = direction * player.speed * 0.7
	player.velocity.x = move_toward(player.velocity.x, target_velocity, 50.0)
	player.move_and_slide()
	if player.velocity.y > 0.1:
		dispatch(&"fall_started")
