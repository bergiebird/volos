@icon("res://addons/_ToyBox/Icons/node/icon_dice.png")
class_name CombatActionDiceBased
extends CombatAction # combat_action_dice_based.gd

# Bergie: Not yet tested because I'm not exactly sure how your TBC system works
# But I think you can understand what I was going for.
# TODO: See if this provides a different result each time


@export_group("Damage")
@export var damage_dice_count:int = 1
@export var damage_dice_sides:int = 6
@export var damage_bonus:int = 0

@export_group("Heal")
@export var heal_dice_count:int = 1
@export var heal_dice_sides:int = 6
@export var heal_bonus:int = 0


func _setup_local_to_scene() -> void:
	var dice_damage:int = DiceWizard.roll_dice(damage_dice_count, damage_dice_sides, damage_bonus)
	var dice_heal:int = DiceWizard.roll_dice(heal_dice_count, heal_dice_sides, heal_bonus)
	if heal > 1:
		push_warning("Heal being rewritten by dice_heal()")
	if damage > 1:
		push_warning("Damage being rewritten by dice_damage()")
	heal = dice_heal
	damage = dice_damage
