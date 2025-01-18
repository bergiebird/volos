@icon("res://addons/_ToyBox/Icons/node/icon_character.png")
class_name WindCharacter
extends TileBasedCharacter

@onready var weapon_character: Bull = $"../Bull"
var tiles


func _on_area_entered(area: TileBasedCharacter) -> void:
	# Wait for the current tween to finish, then clear the list
	await weapon_character.tween.finished
	weapon_character.tween.kill()

	# Spin the weapon
	if weapon_character.current_dir == Vector2.RIGHT:
		weapon_character.move_tiles(&"up", weapon_character.tiles)
	if weapon_character.current_dir == Vector2.LEFT:
		weapon_character.move_tiles(&"up", weapon_character.tiles)
	if weapon_character.current_dir == Vector2.UP:
		weapon_character.move_tiles(&"left", weapon_character.tiles)
	if weapon_character.current_dir == Vector2.DOWN:
		weapon_character.move_tiles(&"right", weapon_character.tiles)
