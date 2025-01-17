extends LimboState #falling_state.gd
var player: CharacterBody2D
var current_velocity: float

func _setup() -> void:
	pass


func _enter() -> void:
	player = get_parent().player

func _exit() -> void:
	pass

func _update(delta: float) -> void:
	if player.is_on_floor():
		dispatch(&"move_started")
	player.move_and_slide()
