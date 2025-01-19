extends TileMapLayer
@export var will_glow = true
@export var glow_color_1: Color = "#f6f2c3"
@export var glow_color_2: Color = "#56212a"
var time=0
var speed=1.0

func _process(delta:float)->void:
	if will_glow:
		glow_tilemap(delta)


func glow_tilemap(delta)->void:
	time+=delta*speed
	var factor = (sin(time)+1)/2
	modulate = glow_color_1.lerp(glow_color_2, factor)
