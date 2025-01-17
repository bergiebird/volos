@icon("res://addons/_ToyBox/Icons/node/icon_crate.png")
class_name ThrowableStats
extends Resource

@export var attributes:Dictionary ={
	#"NAME" = {
		#"can_collect" = BOOL the ability to collect and place resources
		#"strength" = INT the radius of the grenade's explosion
		#"fuse_timer" = FLOAT how long until explosion, if -1 it wont explode unless something else prompts it
		#"size" = INT the size of the physical grenade before explosion
		#"weight" = INT the physics weight of the grenade before explosion
		#"throw_speed" = FLOAT How fast or slow it can be thrown
		#"fx" = NODE which animation it should use
	#},
	"NANO" = {
		"can_collect" = true,
		"strength" = 2,
		"fuse_timer" = 0.1,
		"size" = 2,
		#weight =
		#throw_speed =
		#fx =
		},
}
