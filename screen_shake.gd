extends Camera2D

var rng = RandomNumberGenerator.new()
var random_strength = 30.0
var shake_fade = 5.0
var shake_strength = 200

func _process(delta):
	if Input.is_action_just_pressed("charge"):
		shake_strength = random_strength
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shake_fade*delta)
		offset = Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))
