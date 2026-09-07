@icon("res://Clep&Kog/Pieces/Breakables/Jar.png")
extends Area2D
class_name Sarc

@export var cargo: PackedScene
@export var is_top: bool = false

var broken: bool = false

@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var vfx: GPUParticles2D = $VfxPot
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var static_body: StaticBody2D = $StaticBody2D


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	position = L.snap_to_tile(position)
	sprite.animation = get_sarc() + 's'
	if cargo:
		Levelton.log_this_has_gold_cargo()


func drop_loot() -> void:
	if cargo:
		var loot: Node = cargo.instantiate()
		loot.global_position = global_position
		get_parent().add_sibling(loot)


func _on_area_entered(area: Area2D) -> void:
	if area is Kog and area.charging:
		if !broken:
			static_body.queue_free()
			sfx.play()
			broken = true
			vfx.emitting = true
			sprite.play(get_sarc() + 'r')
			call_deferred("drop_loot")


func get_sarc() -> String:
	return 'top_' if is_top else 'bot_'
