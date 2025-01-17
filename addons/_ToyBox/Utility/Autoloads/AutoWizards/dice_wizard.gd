extends Node # dice_wizard.gd
## A collection of functions to imitate having a D&D dice bag
@onready var rng = RandomNumberGenerator.new()
# 50% chance of returning true or false
func flip_coin() -> bool:
	return randf() > 0.5

# D&D-style dice roll, for example 3d6+2. Returns resulting roll value.
func roll_dice(num_dice:int = 1, num_sides:int = 6, modifier:int = 0) -> int:
	var result = modifier
	print("Rolling ", num_dice, "d", num_sides, " + ", modifier)
	for i in range(0, num_dice):
		result += rng.randi_range(1, num_sides)
	print("Result: ", result)
	return result

func force_roll(forced_result: int, fake_count: int, fake_sides: int, real_modifier: int = 0) -> int:
	var result: int = forced_result + real_modifier
	print("Rolling ", fake_count, "d", fake_sides, " + ", real_modifier)
	return result
	print("Result: ", result, " But to be fair we cheated")

# Roll one or more dice with advantage or disadvantage (if advantage is not true rolls are disadvantaged).
# Returns the highest (advantage) or lowest (disadvantage) value of all rolls.
func roll_dice_5e(num_sides:int = 20, advantage:bool = true, modifier:int = 0) -> int:
	var max_or_min_roll = 1
	var roll
	if advantage:
		for i in range (0, 2):
			roll = roll_dice(1, num_sides)
			if(roll > max_or_min_roll):
				max_or_min_roll = roll
			print("Rolling 2d", num_sides, "with Advantage. Taking the Higher Result")
	else:
		max_or_min_roll = num_sides
		for i in range (0, 2):
			roll = roll_dice(1, num_sides)
			if roll < max_or_min_roll:
				max_or_min_roll = roll
		print("Rolling 2d", num_sides, "with Disadvantage. Taking the Lower Result")
	print("Result: ", max_or_min_roll)
	return max_or_min_roll + modifier


#region Premade Dice Sets
func roll_1d4(modifier : int=0) -> int: return roll_dice(1,4,modifier)
func roll_1d6(modifier : int=0) -> int: return roll_dice(1,6,modifier)
func roll_1d8(modifier : int=0) -> int: return roll_dice(1,8,modifier)
func roll_1d10(modifier : int=0) -> int: return roll_dice(1,10,modifier)
func roll_1d12(modifier : int = 0) -> int: return roll_dice(1,12,modifier)
func roll_1d20(modifier : int=0) -> int: return roll_dice(1,20,modifier)
###
func roll_with_advantage(modifier: int = 0): return roll_dice_5e(20, true, modifier)
func roll_with_disadvantage(modifier: int = 0): return roll_dice_5e(20, false, modifier)

#endregion
