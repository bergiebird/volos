@icon("res://Clep&Kog/Pieces/Breakables/Jar.png")
extends Area2D
class_name Jar

@export var cargo: PackedScene
@export var is_crate: bool
@export var is_crate_open: bool
@export var sfx: AudioStreamPlayer2D
@export var vfx: GPUParticles2D
@export var sprite: AnimatedSprite2D
@export var static_body: StaticBody2D
@onready var parent: Node2D = get_parent() as Node2D

var broken: bool = false


func _ready() -> void:
	position = L.snap_to_tile(position)
	sprite.animation = get_crate()
	area_entered.connect(_on_area_entered)
	if cargo:
		Levelton.log_this_has_gold_cargo()

func drop_loot() -> void:
	if cargo:
		var loot: Node = cargo.instantiate()
		if loot is Gold:
			loot.is_in_open_on_start = false
		loot.global_position = global_position
		parent.add_child(loot)
		var tween: Tween = create_tween()
		await tween.tween_property(self, ^"modulate:a", 0, 2).finished
		tween.kill()
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is Kog and area.charging:
		if !broken:
			static_body.queue_free()
			sfx.play()
			broken = true
			vfx.emitting = true
			sprite.play(get_crate())
			call_deferred("drop_loot")

func get_crate() -> String:
	if broken:
		if is_crate: return 'cb'
		else:        return 'jb'
	else:
		if is_crate:
			if is_crate_open: return 'co'
			else:             return 'cc'
		else:                 return 'jw'
