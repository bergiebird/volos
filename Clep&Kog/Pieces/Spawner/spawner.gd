extends Sprite2D
class_name Spawner

enum Who {CLEP, KOG, MURDERLING}
const SCENES: Dictionary[Who, Resource] = {
	Who.CLEP: preload("uid://bpayqq81cie2c"),
	Who.KOG: preload("uid://bl7e3evmswrme"),
	Who.MURDERLING: preload("uid://c2ettgulcg0c"),
}
@export var who_spawns_here: Who
@export var enemy_difficulty: L.Difficulty
@onready var parent := get_parent() as Node2D

func _ready() -> void:
	var instance := SCENES[who_spawns_here].instantiate() as Node
	if who_spawns_here == Who.MURDERLING:
		instance.difficulty = enemy_difficulty
	instance.position = position - Vector2(16,16)
	parent.add_child.call_deferred(instance)
	instance.z_index += 100
	queue_free()
