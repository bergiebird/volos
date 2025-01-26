#@tool
extends AnimatedSprite2D

signal the_results_of_the_dice_roll(number:int)

@export var start_roll:bool = false
@export var roll_duration:float= 1.0
@export var roll_speed:int = 20
@export var is_silver:bool = false
##Use 0 to not force result
@export_range(0, 6) var force_result:int = 0

var rolling:bool = false
var roll_timer:float
var final_result:int

func _ready()->void:
	stop()

func roll()->void:
	start_roll = false
	rolling = true
	roll_timer = 0.0
	if force_result == 0: final_result = DiceWizard.roll_dice(1, 6, 0)
	else:                 final_result = force_result
	shuffle_frames()
	play("B_ALL")
	speed_scale = roll_speed

func shuffle_frames() -> void:
	var sf = sprite_frames
	var frame_count = sf.get_frame_count("B_ALL")
	var indices = range(frame_count)
	for i in range(frame_count - 1, 0, -1):
		var j = randi() % (i + 1)
		if i != j:
			var temp = sf.get_frame_texture("B_ALL", i)
			var other = sf.get_frame_texture("B_ALL", j)
			var temp_duration = sf.get_frame_duration("B_ALL", i)
			var other_duration = sf.get_frame_duration("B_ALL", j)
			sf.set_frame("B_ALL", i, other, other_duration)
			sf.set_frame("B_ALL", j, temp, temp_duration)

func _process(delta:float)->void:
	if start_roll:
		roll()
	if vec_compare(get_global_mouse_position()):
		if Input.is_action_just_released("interact"):
			if not rolling:
				$ScaleSpriteComponent_2.tween_scale()
				roll()
	if not rolling:
		return
	roll_timer += delta
	if roll_timer >= roll_duration:
		$ScaleSpriteComponent_2.tween_scale()
		rolling = false
		play("B_" + str(final_result))
		@warning_ignore("return_value_discarded")
		emit_signal("the_results_of_the_dice_roll", final_result)
		stop()

func vec_compare(main_pos:Vector2)->bool:
	var min_pos = global_position - Vector2(9,9)
	var max_pos = global_position + Vector2(9,9)
	return main_pos.x >= min_pos.x\
	   and main_pos.y >= min_pos.y\
	   and main_pos.x <= max_pos.x\
	   and main_pos.y <= max_pos.y
