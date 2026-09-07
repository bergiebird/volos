extends Node
#class_name Levelton

signal update_score(i:int)

var max_score: int


func log_this_has_gold_cargo() -> void:
	max_score += 1

func on_level_over() -> void:
	max_score = 0

func get_max_score() -> int:
	return max_score
