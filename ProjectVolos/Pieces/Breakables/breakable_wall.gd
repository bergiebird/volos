@icon("res://ProjectVolos/Pieces/Breakables/breakable_wall.png")
@tool
extends Area2D
@export var is_vertical :bool = false
@export var is_fence :bool=false
@onready var static_wall = %StaticBody2D
@onready var sprite = $AnimatedSprite2D
@onready var sfx_wall_concrete: AudioStreamPlayer2D = %SfxWallConcrete
@onready var sfx_wall_metal: AudioStreamPlayer2D = %SfxWallMetal
#@onready var vfx_wall: GPUParticles2D = $VfxWall
var broken :bool = false

func _ready():
	sprite.animation = get_wall_type()+'s'

func _process(delta):
	if Engine.is_editor_hint():
		sprite.animation = get_wall_type()+'s'

func _on_area_entered(area :Area2D)->void:
	if area.name == "Kog" and area.charging:
		if !broken:
			%StaticBody2D.queue_free()
			if is_fence: sfx_wall_metal.play()
			else: sfx_wall_concrete.play()
			broken = true
			#vfx_wall.emitting = true
			sprite.play((get_wall_type()+'r'))
			static_wall.queue_free()

func get_wall_type():
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
