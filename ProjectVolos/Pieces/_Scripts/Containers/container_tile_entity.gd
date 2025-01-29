@icon("res://ProjectVolos/Pieces/Breakables/Jar.png")
@tool
class_name Jar
extends Area2D
@export var cargo: PackedScene
@export var is_crate :bool=false
@export var is_crate_open :bool =false
@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var vfx: GPUParticles2D = $VfxPot
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var broken :bool = false

func _ready():
	sprite.animation = get_crate()

func _process(delta):
	if Engine.is_editor_hint():
		sprite.animation = get_crate()

func drop_loot()->void:
	if cargo:
		var loot :Node = cargo.instantiate()
		loot.global_position = global_position
		get_parent().add_sibling(loot)

func _on_area_entered(area: Area2D):
	if area.name == "Kog" and area.charging:
		if !broken:
			%StaticBody2D.queue_free()
			%AfterBreak.start()
			sfx.play()
			broken = true
			vfx.emitting = true
			sprite.play(get_crate())
			drop_loot()

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
