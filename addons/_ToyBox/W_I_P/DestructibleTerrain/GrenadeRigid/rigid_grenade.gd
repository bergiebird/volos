@icon("res://addons/_ToyBox/Icons/node_2D/icon_area_damage.png")
extends Node2D #rigid_grenade.gd
signal grenade_explosion(global_pos, strength)
@export var debug:bool = false
@onready var stats:ThrowableStats = load("res://addons/_ToyBox/Systems/DestructibleTerrain/GrenadeRigid/throwable_stats.tres")
@onready var throwable:RigidBody2D = get_child(0)
@onready var collectible:Node2D = get_child(1)
@onready var boom_sfx:AudioStreamPlayer2D = get_child(2)
@onready var trigger_types:Node = get_child(3)
@export_range(0,3) var trigger: int = 0
@onready var map:Node = get_tree().root.find_child("DestroyMap", true, false)
@onready var initial_velocity:Vector2 = Vector2.ZERO
@onready var collectible_value:int = 0
@onready var has_not_exploded:bool = false
var grenade
func _ready()->void:
	_debug(6)
	if map != null: connect("grenade_explosion", Callable(map, "create_explosion"))
	else: _debug(0)
	if stats != null:
		grenade = stats.attributes.NANO # Statically set, should be dynamic later
		has_not_exploded = true
	else: _debug(1)
	trigger_types.what_trigger_type(trigger)
	throwable.linear_velocity = initial_velocity

func setup(spawn_pos:Vector2, spawn_rot:float, throw_dir:float, throw_speed:float, _type:String = "TNT")->void:
	global_position = spawn_pos + Vector2(4,0)
	global_rotation = spawn_rot
	initial_velocity = Vector2(throw_speed, 0).rotated(throw_dir)

func set_collectable(destroyed_tiles:int)->void:
	collectible_value = destroyed_tiles
	collectible.visible = true

func start_explosion()->void:
	if has_not_exploded:
		boom_sfx.volume_db += (grenade.strength*3)
		boom_sfx.play()
		has_not_exploded = false
		emit_signal("grenade_explosion", throwable.global_position, grenade.strength, self.name)
		_debug(2)
		collectible.position = throwable.position
		throwable.queue_free()
		collectible.visible = true
	else:
		_debug(3)

func _on_area_2d_body_entered(body)->void:
	if collectible.visible == true:
		if body is CharacterBody2D:
			#PlayerInventory.add_to_tiles_in_storage(collectible_value)
			queue_free()

func _debug(num:int)->void:
	if not debug: return
	print('~~~~~~~',self.name)
	match num:
		0: print("cannot find DestoryMap in tree")
		1: print("cannot find ThrowableStats")
		2: print(self.name)
		3: print('woopsie, no explosion')
		4: print('Couldnt identify Trigger')
		6: print('debug on')
		_: print('nothing')
