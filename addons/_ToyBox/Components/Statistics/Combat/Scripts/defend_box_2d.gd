@icon("res://addons/_ToyBox/Icons/node_2D/icon_shield.png")
class_name DefendBox2D
extends Area2D

@export var hp: HealthStatistics
@export var defense: float = 0.0 : set = set_defense, get = get_defense

func take_damage(amount):
	var damage = amount - defense
	if damage > 0.0:
		hp.damage(damage)

func receive_healing(amount):
	if amount > 0.0:
		hp.heal(amount)

func set_defense(new_def: float) -> void: defense = new_def
func get_defense() -> float: return defense
