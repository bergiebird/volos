@icon("res://Clep&Kog/Pieces/Breakables/breakable_wall.png")
extends Area2D
class_name BreakableWall

@export var is_vertical: bool = false
@export var is_fence: bool =false
@export var sprite: AnimatedSprite2D
@export var sfx_wall_concrete: AudioStreamPlayer2D
@export var sfx_wall_metal: AudioStreamPlayer2D
@export var broken: bool = false
@export var staticb: StaticBody2D
@export var hwoc: LightOccluder2D
@export var vwoc: LightOccluder2D
@export var vfoc: Node2D
@export var hfoc: Node2D

var exit_gate_created: bool = false



func _ready() -> void:
	var parent: Node2D = get_parent() as Node2D
	if is_fence:
		hwoc.queue_free()
		vwoc.queue_free()
		vfoc.queue_free()
		hfoc.queue_free()
	if parent is TileMapLayer:
		parent.add_to_group(&"Walls")
	position = L.snap_to_tile(position)
	sprite.animation = get_wall_type()+'s'
	if broken:
		set_wall_collisions(false, self)
		#staticb.collision_layer = staticb.collision_layer #AI
		sprite.play((get_wall_type()+'r'))


func _on_area_entered(area: Area2D) -> void:
	if area is Kog and area.charging:
		if !broken:
			Signalton.emit_speed_up()
			set_wall_collisions(false, self)
			sfx_wall_metal.play() if is_fence else sfx_wall_concrete.play()
			broken = true
			sprite.play((get_wall_type()+'r'))
			if hwoc: hwoc.visible = false
			if vwoc: vwoc.visible = false
			if hfoc: hfoc.visible = false
			if vfoc: vfoc.visible = false
	if area is Murderling and broken:
		Signalton.emit_mummy_is_rebuilding()
		sprite.play((get_wall_type()+'s'))
		broken = false
		set_wall_collisions(true, self)


func get_wall_type() -> String:
	if is_vertical:
		if is_fence:
			if vfoc:
				vfoc.visible = true
			return 'vf'
		else:
			if vwoc:
				vwoc.visible = true
			return 'vw'
	else:
		if is_fence:
			if hfoc:
				hfoc.visible = true
			return 'hf'
		else:
			if hwoc:
				hwoc.visible = true
			return 'hw'

func set_wall_collisions(bol: bool, who: CollisionObject2D) -> void:
	who.set_collision_layer_value(2, bol)
	who.set_collision_layer_value(6, bol)
