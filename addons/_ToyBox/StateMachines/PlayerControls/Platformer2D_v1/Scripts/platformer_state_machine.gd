extends LimboHSM
@onready var idle_state: LimboState = $IdleState
@onready var move_state: LimboState = $MoveState
@onready var jump_state: LimboState = $JumpState
@onready var falling_state: LimboState = $FallingState
@export var player: CharacterBody2D
@export var debug: bool

func _ready()->void:
	add_transition(idle_state, move_state, &"move_started")
	add_transition(move_state, idle_state, &"move_ended")
	add_transition(ANYSTATE, idle_state, &"state_ended")
	add_transition(ANYSTATE, jump_state, &"jump_started")
	add_transition(ANYSTATE, falling_state, &"fall_started")
	add_transition(falling_state, move_state, &"move_started")
	initial_state = idle_state
	initialize(self)
	set_active(true)

func _physics_process(delta)->void: # VROOD, moved to put all player functionality into the state machines -Bergie
	if not player.is_on_floor():
		player.velocity.y += player.get_gravity().y * delta
