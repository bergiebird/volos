@icon("res://ProjectVolos/Pieces/Breakables/Jar.png")
#@tool
extends Area2D
@export var cargo: PackedScene
@export var is_top :bool = false
var is_crate :bool=false
var is_crate_open :bool =false
@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var vfx: GPUParticles2D = $VfxPot
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var static_body :StaticBody2D = %StaticBody2D
var broken :bool = false
var time :float = 0.0

func _ready()->void:
	snap_to_tile()
	sprite.animation = get_sarc() + 's'

func drop_loot()->void:
	if cargo:
		var loot :Node = cargo.instantiate()
		loot.global_position = global_position
		get_parent().add_sibling(loot)

func _on_area_entered(area: Area2D)->void:
	if area.name == "Kog" and area.charging:
		if !broken:
			static_body.queue_free()
			sfx.play()
			broken = true
			vfx.emitting = true
			sprite.play(get_sarc() + 'r')
			call_deferred("drop_loot")
			Signalton.speed_up.emit()
			Signalton.speed_up.emit()
			Signalton.speed_up.emit()

func get_sarc()->String:
	if is_top:
		return 'top_'
	else:
		return 'bot_'

func snap_to_tile()->void:
	position = round(position / 16) * 16
