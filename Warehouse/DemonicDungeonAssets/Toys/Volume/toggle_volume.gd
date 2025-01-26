extends AnimatedSprite2D

signal new_volume_signal(num:int)

@export var is_silver = true
@onready var number:int = 9
@onready var pos = global_position
@onready var index = 0
var min_pos:Vector2
var max_pos:Vector2
var prefix

func _ready():
	if is_silver == true: prefix = "S"
	else:                 prefix = "B"
	min_pos = pos - Vector2(number,number)
	max_pos = pos + Vector2(1,number)

func _process(delta:float)->void:
	var anim = prefix + str(index)
	if vec_compare(get_global_mouse_position()):
		if Input.is_action_just_released("interact"):
			$ScaleSpriteComponent.tween_scale()
			index += 1
			if index >= 4:
				index = 0
			emit_signal("new_volume_signal", index)
		play(anim+'H')
	else:
		play(anim+'G')

func vec_compare(main_pos:Vector2)->bool:
	return main_pos.x >= min_pos.x\
	   and main_pos.y >= min_pos.y\
	   and main_pos.x <= max_pos.x\
	   and main_pos.y <= max_pos.y
