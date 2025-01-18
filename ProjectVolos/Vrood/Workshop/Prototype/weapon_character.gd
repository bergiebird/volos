class_name WeaponCharacter
extends TileBasedCharacter
# weapon_character.gd

@onready var ray: RayCast2D = $Ray
@export var tiles: int = 3 # how many tiles the character moves in a single input
@export var move_rate := 5
var moving := false
var current_dir: Vector2
var tween: Tween



const INPUTS: Dictionary = {"up": Vector2.UP,
						"left": Vector2.LEFT,
						"right": Vector2.RIGHT,
						"down": Vector2.DOWN,
						}

func _unhandled_input(event):
	if moving: return
	for direct in INPUTS.keys():
		if event.is_action_pressed(direct):
			current_dir = INPUTS[direct]
			move_tiles(direct, tiles)



func move_tiles(direct: StringName, tiles: int):
	update_raycast(direct)
	if ray.is_colliding(): return
	for t in range(tiles):
		tween = create_tween()
		moving = true
		tween.tween_property(self, "position",
				position + INPUTS[direct] * tile_size,
				1.0/move_rate).set_trans(Tween.TRANS_SINE)
		await tween.finished
		moving = false


func _on_area_entered(area: TileBasedCharacter) -> void:
	if area is not TileBasedCharacter: return
	if area.is_in_group("Strongling"):
		#area.get_shoved()
		area.global_position += current_dir.orthogonal() * tile_size #move to side
	elif area.is_in_group("Weakling"):
		#area.die()
		NodeRemover.remove(area) # run it over

func update_raycast(direct):
	ray.target_position = INPUTS[direct] * tile_size
	ray.force_raycast_update()
