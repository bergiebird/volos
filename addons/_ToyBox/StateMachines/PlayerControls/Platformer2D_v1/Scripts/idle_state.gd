extends LimboState #idle_state.gd

var player:CharacterBody2D

func _setup()->void:
	pass

func _enter()->void:
	player = get_parent().player
	player.velocity = Vector2.ZERO
	if player.debug:
		print("Idle_enter")

func _exit()->void:
	if player.debug:
		print("Idle_exit")

func _update(delta:float)->void:
	var direction:float = Input.get_axis("move_left", "move_right")
	if direction != 0:
		dispatch(&"move_started")
	if not player.is_on_floor():
		dispatch(&"falling_started")
	player.move_and_slide()

func _input(event: InputEvent):
	if event.is_action("jump"):
		dispatch(&"jump_started")
