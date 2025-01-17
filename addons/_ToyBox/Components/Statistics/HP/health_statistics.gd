
class_name HealthStatistics
extends Node


signal max_hp_changed(diff: float)
signal hp_changed(diff: float)
signal hp_0

#Export Land
@export_range(0.0,100.0,1, "or_greater") var max_hp: float = 10.0 : set = set_max_hp, get = get_max_hp
@export_range(0.0,100.0,1, "or_greater") var start_hp: float = 10.0
@export var immortal: bool = false : set = set_immortality, get = is_immortal

@onready var hp: float = start_hp


# Functional Land
func damage(dmg_amount: float): set_hp(hp - dmg_amount)
func heal(heal_amount: float): set_hp(hp + heal_amount)

func reduce_max_hp(amount: float): set_max_hp(max_hp - amount)
func increase_max_hp(amount: float): set_max_hp(max_hp + amount)


# Set temporary immortality!
var i_frame_timer: Timer
func i_frames(seconds: float):
# creates a timer if we don't have one
	if i_frame_timer == null:
		i_frame_timer = Timer.new()
		i_frame_timer.one_shot = true
		add_child(i_frame_timer)
# if we do have a timer, lets just hijack its signal, we're just extending the iframe duration
	if i_frame_timer.timeout.is_connected(set_immortality):
		i_frame_timer.timeout.disconnect(set_immortality)

# connect the timer's timeout to make immortality = false, then we'll set it to true and start the timer
	i_frame_timer.timeout.connect(set_immortality.bind(false))
	set_immortality(true)
	i_frame_timer.start(seconds)




#region Getters/Setters
# Immortality
func is_immortal() -> bool: return immortal
func set_immortality(state: bool): immortal = state

# HERE BE JANK. Everything else up top is pretty. Be wary traveller, only brave souls should venture on
# Max HP
func get_max_hp() -> float: return max_hp
func set_max_hp(value: float):
	# Minimum 1, otherwise it can be whatevs
	var clamp = 1.0 if value <= 0.0 else value
	# if our clamp and max_hp are the same, we never switched hp so we don't need to emit signals
	if clamp != max_hp:
		# but if they aren't the same, we can go ahead
		var dif = clamp - max_hp
		max_hp = value
		max_hp_changed.emit(dif)

		if hp > max_hp: hp = max_hp

# HP
func get_hp() -> float: return hp
func set_hp(value: float):
	#if we try to dmg while immortal, return
	if value < hp and is_immortal(): return

	# same as before but with a different clamp
	var clamp = clampf(value, 0.0, max_hp)
	if clamp != hp:
		var dif = clamp - hp
		hp = value
		hp_changed.emit(dif)

	# Well... https://youtu.be/-ZGlaAxB7nI
		if hp == 0.0:
			hp_0.emit()

#endregion
