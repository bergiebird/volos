@icon("res://addons/_ToyBox/Icons/node/icon_money_bag.png")
class_name BreakableTile
extends TileBasedEntity


@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var cargo: PackedScene # works same as preload


func play_sfx():
	pass

func play_vfx():
	pass

func drop_loot():
	if cargo:
		var loot = cargo.instantiate()
		loot.position = position
		add_sibling(loot)

func _exit_tree() -> void:
	await play_effects()
	await drop_loot()

func play_effects():
	play_sfx()
	play_vfx()
