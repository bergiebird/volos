## class_name Signalton
extends Node

##

#signal#

#func emit_() -> void:
#	.emit()

##

signal wall_broken()

func emit_wall_broken() -> void:
	wall_broken.emit()

##

signal add_to_score(by_how_much: int)

func emit_add_to_score(by_how_much: int) -> void:
	add_to_score.emit(by_how_much)

##

signal level_complete()

func emit_level_complete() -> void:
	level_complete.emit()

##

signal speed_up()

func emit_speed_up() -> void:
	speed_up.emit()

##

signal stun_mummy(who: Node2D)

func emit_stun_mummy(who: Node2D) -> void:
	stun_mummy.emit(who)

##

signal mummy_is_rebuilding()

func emit_mummy_is_rebuilding() -> void:
	mummy_is_rebuilding.emit()

##

signal enough_treasure_collected()

func emit_enough_treasure_collected() -> void:
	enough_treasure_collected.emit()

##

signal initiate_capture()

func emit_initiate_capture() -> void:
	initiate_capture.emit()

##

signal kog_save()

func emit_kog_save() -> void:
	kog_save.emit()

##

signal level_lost()

func emit_level_lost() -> void:
	level_lost.emit()
