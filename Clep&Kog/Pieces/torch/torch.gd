@icon("res://Clep&Kog/_Main_Scenes/torch.png")
extends Node2D
class_name Torch


func _ready() -> void:
	position = L.snap_to_tile(position)
