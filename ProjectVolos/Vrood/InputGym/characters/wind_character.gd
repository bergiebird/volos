@icon("res://addons/_ToyBox/Icons/node/icon_character.png")
class_name WindMage
extends TileBasedCharacter

@onready var bull: Bull = $"../Bull"
var tiles

func _on_area_entered(_area:TileBasedCharacter)->void:
	await wait_n_kill()
	spin_bull()

func spin_bull():
	if bull.current_dir == Vector2.RIGHT:
		bull.move_tiles(&"up", bull.tiles)
	if bull.current_dir == Vector2.LEFT:
		bull.move_tiles(&"up", bull.tiles)
	if bull.current_dir == Vector2.UP:
		bull.move_tiles(&"left", bull.tiles)
	if bull.current_dir == Vector2.DOWN:
		bull.move_tiles(&"right", bull.tiles)

func wait_n_kill():
	await bull.tween.finished
	bull.tween.kill()
