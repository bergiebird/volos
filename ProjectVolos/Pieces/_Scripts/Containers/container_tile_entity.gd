@icon("res://ProjectVolos/Pieces/Containers/Jar.png")
class_name ContainerTileEntity
extends Area2D
@export var cargo: PackedScene
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var vfx_pot: GPUParticles2D = $VfxPot
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var broken: bool = false

func _exit_tree() -> void:
	if cargo:
		drop_loot()

func drop_loot() -> void:
		var loot: Node = cargo.instantiate()
		loot.global_position = global_position
		add_sibling(loot)

func _on_area_entered(area: Area2D):
	if area.name == "Kog" and area.charging:
		print("ka-pow")
		if !broken:
			broken = true
			vfx_pot.emitting = true
		animated_sprite_2d.play("Broken_Jb")