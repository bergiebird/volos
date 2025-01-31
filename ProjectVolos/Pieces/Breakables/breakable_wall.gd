@icon("res://ProjectVolos/Pieces/Breakables/breakable_wall.png")
extends Area2D
@export var is_vertical :bool = false
@export var is_fence :bool=false
@onready var sprite = $AnimatedSprite2D
@onready var sfx_wall_concrete: AudioStreamPlayer2D = %SfxWallConcrete
@onready var sfx_wall_metal: AudioStreamPlayer2D = %SfxWallMetal
@export var broken :bool = false
var exit_gate_created = false
@onready var staticb :StaticBody2D = %StaticStopper

func _ready()->void:
	snap_to_tile()
	sprite.animation = get_wall_type()+'s'
	if broken:
		staticb.set_collision_layer_value(2, false)
		sprite.play((get_wall_type()+'r'))

func _on_area_entered(area :Area2D)->void:
	if area.name == "Kog" and area.charging:
		if !broken:
			Signalton.speed_up.emit()
			staticb.set_collision_layer_value(2, false)
			if is_fence:
				sfx_wall_metal.play()
			else:
				sfx_wall_concrete.play()
			broken = true #vfx_wall.emitting = true
			sprite.play((get_wall_type()+'r'))
	if area.name == 'Murderling' and broken:
		Signalton.mummy_is_rebuilding.emit()
		sprite.play((get_wall_type()+'s'))
		broken = false
		await get_tree().create_timer(1).timeout
		staticb.set_collision_layer_value(2, true)

func get_wall_type()->String:
	if is_vertical:
		if is_fence:
			return 'vf'
		else:
			return 'vw'
	else:
		if is_fence:
			return 'hf'
		else:
			return 'hw'

func snap_to_tile()->void:
	position = round(position / 16) * 16
