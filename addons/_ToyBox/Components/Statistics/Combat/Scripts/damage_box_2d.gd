@icon("res://addons/_ToyBox/Icons/node_2D/icon_projectile.png")
class_name DamageBox2D
extends Area2D

@export var damage: int : get = get_damage_amount, set = set_damage_amount

func _on_area_entered(area):
	if area is DefendBox2D:
		area.take_damage(damage)

func get_damage_amount() -> int: return damage
func set_damage_amount(new_amount) -> void:
	if new_amount > 0:
		damage = new_amount
