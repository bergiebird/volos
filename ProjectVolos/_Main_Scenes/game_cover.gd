extends NinePatchRect

@onready var take2kog :Label = %take2_kog
@onready var take3kog :Label = %take3_kog
@onready var take2klep :Label = %take2_klep
@onready var take2kog2 :Label = %take2_kog2
@onready var take3klep :Label = %take2_klep
@onready var take3start :Label = %take3_start
var count :int = 0
func _ready()->void:
	Signalton.level_lost.connect(display_hint)

func display_hint()->void:
	take2kog.visible = true
	take2klep.visible = true
	take2kog2.visible = true
	if count >= 1:
		take3klep.visible = true
		take3kog.visible = true
		take3start.visible = true
	count +=1
