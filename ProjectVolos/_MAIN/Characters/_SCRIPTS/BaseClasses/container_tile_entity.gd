@icon("res://addons/_ToyBox/Icons/node/icon_money_bag.png")
class_name ContainerTileEntity
extends TileBasedEntity # breakable_tile_entity.gd

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D




@export var cargo: PackedScene

func _exit_tree() -> void:
	if cargo:
		drop_loot()
func drop_loot():
		var loot = cargo.instantiate()
		loot.global_position = global_position
		add_sibling(loot)
