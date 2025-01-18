@icon("res://addons/_ToyBox/Icons/color/icon_weapon.png")
class_name Bull
extends TileBasedCharacter # weapon_character.gd

@export var INPUTS: Resource
@onready var ray: RayCast2D = $Ray
@export var charge_tiles: int = 3 # how many tiles the character moves in a single input
@export var move_rate := 5
var moving := false
var current_dir: Vector2
var tween: Tween

func _unhandled_input(event):
	if moving:
		return
	for input in INPUTS.keys():
		if event.is_action_pressed(input):
			current_dir = INPUTS[input]
			move_tiles(input, charge_tiles)

func move_tiles(direct: StringName, _tiles: int):
	update_raycast(direct)
	if ray.is_colliding():
		return
	for i in range(_tiles):
		tween = create_tween()
		moving = true
		tween.tween_property(self, "position",
				position + INPUTS[direct] * tile_size,
				1.0/move_rate).set_trans(Tween.TRANS_SINE)
		await tween.finished
		moving = false


func _on_area_entered(area: TileBasedCharacter) -> void:
	if area is not TileBasedCharacter:
		return
	if area.is_in_group("Strongling"):
		#area.get_shoved()
		area.global_position += current_dir.orthogonal() * tile_size #move to side
	elif area.is_in_group("Weakling"):
		#area.die()
		NodeRemover.remove(area) # run it over

func update_raycast(direct):
	ray.target_position = INPUTS[direct] * tile_size
	ray.force_raycast_update()
