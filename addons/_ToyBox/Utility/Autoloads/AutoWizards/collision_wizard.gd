extends Node # call CollisionWizard singleton


## Useful for not having to memorize which layer does what, we can instead
## refer to them by name
const environment_collision_layer: int = 1
const player_collision_layer: int = 2
const enemy_collision_layer: int = 4
const collectible_collision_layer: int = 8
const projectile_collision_layer: int = 16
const interact_collision_layer: int = 32
const hitbox_collision_layer: int = 64
const another_collision_layer: int = 128




@warning_ignore("narrowing_conversion")
func collision_layer_to_value(layer: int) -> int:
	layer = clampi(layer, 1, 32)

	return pow(2, layer - 1)
