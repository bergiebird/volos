@icon("res://addons/_ToyBox/Icons/node_2D/icon_pot.png")
class_name HealBox2D
extends Area2D

@export var healing: int : get = get_healing_amount, set = set_healing_amount

func _on_area_entered(area):
	if area is DefendBox2D:
		area.receive_healing(healing)

func get_healing_amount() -> int: return healing
func set_healing_amount(new_amount):
	if new_amount > 0:
		healing = new_amount
