@tool
@icon("res://addons/_ToyBox/Icons/node_2D/icon_reset.png")
extends Node2D #twister.gd

func _ready()->void:
	set_editor_description("
	LU 1/20/25

	This scene contains 4 cardinal directions which shoots the character
	in either direction
	")


func _on_send_north_area_entered(character :TileBasedCharacter)->void:
	Signalton.twister_entered.emit

func _on_send_east_area_entered(character :TileBasedCharacter)->void:
	Signalton.twister_entered.emit

func _on_send_south_area_entered(character :TileBasedCharacter)->void:
	Signalton.twister_entered.emit

func _on_send_west_area_entered(character :TileBasedCharacter)->void:
	Signalton.twister_entered.emit
