extends Area2D

@onready var ray: RayCast2D = $Ray
@export var tile_size: int = 16
@export var tiles: int = 30
@export var move_rate := 120
var moving := false
var current_dir

const INPUTS: Dictionary = {"up": Vector2.UP,
						"left": Vector2.LEFT,
						"right": Vector2.RIGHT,
						"down": Vector2.DOWN}


func _ready() -> void:
	snap_to_grid()


func _unhandled_input(event):
	if moving: return
	for direct in INPUTS.keys():
		if event.is_action_pressed(direct):
			current_dir = INPUTS[direct]
			move_to_next_tile(direct, tiles)


func move_to_next_tile(direct: StringName, tiles: int):
	while tiles > 0:
		update_raycast(direct)
		if not ray.is_colliding():
			#position += INPUTS[direct] * tile_size
			var tween = create_tween()
			tween.tween_property(self, "position",
						position + INPUTS[direct] * tile_size,
						1.0/move_rate).set_trans(Tween.TRANS_SINE)
			moving = true
			await tween.finished
			moving = false
			tiles -= 1
		else:
			tiles = -1



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Strongling"):
		#area.get_shoved()
		area.global_position += current_dir.orthogonal() * tile_size
	elif area.is_in_group("Weakling"):
		#area.die()
		NodeRemover.remove(area) # run it over

func update_raycast(direct):
	ray.target_position = INPUTS[direct] * tile_size
	ray.force_raycast_update()

func snap_to_grid(): #NOTE has tendency to snap character down and to the right one tile
	position = position.snapped(Vector2.ONE * tile_size/2)
