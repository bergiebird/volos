extends Node2D

@export var player_char:Node
@export var enemy_char:Node
@export var turn_delay:float = 1.0
var cur_char:Character
var game_over:bool = false

func _ready():
	SignalTown.end_turn.connect(_before_next_turn)
	SignalTown.character_died.connect(_game_over)
	await get_tree().create_timer(turn_delay).timeout
	begin_next_turn()

func begin_next_turn():
	find_current_char()
	await get_tree().create_timer(turn_delay).timeout
	SignalTown.emit_signal("begin_turn",cur_char)

func _before_next_turn():
	await get_tree().create_timer(turn_delay).timeout
	if game_over == true:
		pass
	else:
		begin_next_turn()

func _game_over(character):
	game_over = true
	if character.is_player == true:
		print("Game Over!")
	else:
		print("You Win!")

func find_current_char():
	if cur_char == player_char:
		cur_char = enemy_char
	elif cur_char == enemy_char:
		cur_char = player_char
	else:
		cur_char = player_char
