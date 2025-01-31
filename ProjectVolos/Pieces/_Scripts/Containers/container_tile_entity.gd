@icon("res://ProjectVolos/Pieces/Breakables/Jar.png")
class_name Jar
extends Area2D
@export var cargo: PackedScene
@export var is_crate :bool=false
@export var is_crate_open :bool =false
@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var vfx: GPUParticles2D = $VfxPot
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var after_break :Timer = %AfterBreak
@onready var static_body :StaticBody2D = %StaticBody2D
var broken :bool = false
var time :float = 0.0

func _ready()->void:
	snap_to_tile()
	sprite.animation = get_crate()

func _process(delta)->void:
	if Engine.is_editor_hint():
		sprite.animation = get_crate()
	time += delta
	if broken:
		modulate.a = lerp(0, 1, (sin(time*.1)+1) / 2)
		if modulate.a == 0:
			queue_free()

func drop_loot()->void:
	if cargo:
		var loot :Node = cargo.instantiate()
		loot.global_position = global_position
		get_parent().add_sibling(loot)

func _on_area_entered(area: Area2D)->void:
	if area.name == "Kog" and area.charging:
		if !broken:
			static_body.queue_free()
			after_break.start()
			sfx.play()
			broken = true
			vfx.emitting = true
			sprite.play(get_crate())
			call_deferred("drop_loot")

func get_crate()->String:
	if broken:
		if is_crate:
			return 'cb'
		else:
			return 'jb'
	else:
		if is_crate:
			if is_crate_open:
				return 'co'
			else:
				return 'cc'
		else:
			return 'jw'


func _on_after_break_timeout() -> void:
	queue_free()
func snap_to_tile():
	position = round(position / 16) * 16
