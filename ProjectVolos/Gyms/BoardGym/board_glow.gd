@tool
@icon("res://addons/_ToyBox/Icons/node/icon_grid.png")
extends Node2D # board_glow.gd
@export_category("Board Glow")
@export var will_glow :bool  = true
@export var will_change_color :bool  = true
@export var will_change_transparency :bool = true
@export var starting_color :Color = "#6a6a6a"
@export var glow_to_color :Color = "#a84759"
@export var color_change_speed :float=1.0
@export var transparency_change_speed :float=1.0
@export var transparency_minimum :float = 0.4
@export var transparency_maximum :float = 1.0
var time :float=0

func _process(delta :float)->void:

	if will_glow:
		glow_tilemap(delta)

func glow_tilemap(delta :float)->void:
	time+=delta # This needs to exist outside of if statements or else it will get choppy
	if will_change_color:
		modulate = starting_color.lerp(glow_to_color, (sin(time*color_change_speed)+1) / 2)
	if will_change_transparency and %Playable:
		%Playable.modulate.a = lerp(transparency_minimum, transparency_maximum ,(sin(time*transparency_change_speed)+1) / 2)
