extends LimboState #move_state.gd
## Called once, when state is initialized.


var player: CharacterBody2D

func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	player = get_parent().player
	if player.debug: print("Move_enter")

## Called when state is exited.
func _exit() -> void:
	if player.debug: print("Move_exit")

## Called each frame when this state is active.
func _update(delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")
	PF_MOVEMENT_MODULE.move(player, direction)
	player.move_and_slide()
	if player.velocity.x == 0.0:
		dispatch(&"move_ended")
	elif Input.is_action_pressed("jump"):
		dispatch(&"jump_started")
