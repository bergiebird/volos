@icon("res://addons/_ToyBox/Icons/color/icon_weapon.png")
class_name Bull
extends TileBasedCharacter # bull.gd
@export var resource_dictionary: Resource = preload("res://ProjectVolos/BergieBird/Working/resources/input_dictionary.tres")
@onready var inputs: Dictionary = resource_dictionary.dict
@export var charge_speed :int = 3
@export var move_speed :int = 1
@export var move_rate := 5
var moving :bool = false
var current_dir :Vector2
var tween :Tween
@onready var ray :RayCast2D = $Ray

func _unhandled_input(event):
	if moving: return
	for key in inputs.keys():
		if event.is_action_pressed(key):
			update_currents(key)
			move_tiles(key, charge_speed)

func move_tiles(key:StringName, _tiles:int)->void:
	update_currents(key)
	if ray.is_colliding(): return
	for i in range(_tiles):
		tween = create_tween()
		moving = true
		tween.tween_property(self, "position",
				position + inputs[key] * tile_size,
				1.0/move_rate).set_trans(Tween.TRANS_SINE)
		await tween.finished
		moving = false

func _on_area_entered(character:TileBasedCharacter)->void:
	if character is not TileBasedCharacter: return
	if character.is_in_group("Strongling"): shove(character)
	elif character.is_in_group("Weakling"): trample(character)
	else:                                   printt(character, 'this entity is beyond our scope of understanding has collided with our bull')

func update_currents(key:StringName)->void:
	current_dir = inputs[key]
	ray.target_position = current_dir * tile_size
	ray.force_raycast_update()

func trample(character)->void:
	#character.die()
	NodeRemover.remove(character)

func shove(character)->void:
		#character.get_shoved()
		character.global_position += current_dir.orthogonal() * tile_size #move to side
