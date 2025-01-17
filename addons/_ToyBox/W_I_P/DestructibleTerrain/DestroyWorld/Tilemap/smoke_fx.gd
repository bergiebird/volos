@icon("res://addons/_ToyBox/Icons/node_2D/icon_scene.png")
extends Node2D
@export_range(0.001,0.1) var rate_of_dissipation: float
@export_range(0, 10) var animation_choice: int = 0
@export var node_boom: Node
@export var color_boom: Color
@export var node_smoke: Node
@export var color_smoke: Color
@export var node_sfx: Node
@export var debug: bool = false
var once: bool = false
var did_all_anims_finish: int = 0

func _ready()->void:
	if !node_boom: node_boom = %Boom_VFX
	if !node_smoke: node_smoke = %Smoke_VFX
	if !node_sfx: node_sfx = %Boom_SFX
	if !node_boom.animation_finished.is_connected(_on_boom_vfx_animation_finished):
		node_boom.animation_finished.connect(_on_boom_vfx_animation_finished)
	if !node_smoke.animation_finished.is_connected(_on_smoke_vfx_animation_finished):
		node_smoke.animation_finished.connect(_on_smoke_vfx_animation_finished)
	if !node_sfx.finished.is_connected(_on_boom_sfx_finished):
		node_sfx.finished.connect(_on_boom_sfx_finished)
	set_boom_smoke()

func _process(_delta)->void:
	node_boom.modulate.a -= rate_of_dissipation
	node_smoke.modulate.a -= rate_of_dissipation*2.0
	if did_all_anims_finish >= 3:
		queue_free()

func set_boom_smoke()->void:
	node_boom.set_modulate(color_boom)
	node_smoke.set_modulate(color_smoke)
	node_sfx.play()
	node_boom.play()
	node_smoke.play()

func _on_smoke_vfx_animation_finished()->void:
	did_all_anims_finish += 1
	node_smoke.visible = false

func _on_boom_vfx_animation_finished()->void:
	did_all_anims_finish += 1
	node_boom.visible = false

func _on_boom_sfx_finished() -> void:
	did_all_anims_finish += 1
	#PlayerInventory.add_to_tiles_in_storage(1)
