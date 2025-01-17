@icon("res://addons/_ToyBox/Icons/color/icon_map_2.png")
class_name DestroyableWorldEnvironment
extends WorldEnvironment

@export var destr_map: DestroyableTileMapComponent
@export var glow_on_explosion_modifier:float = 0.2
@export var debug: bool = false
func _ready()->void:
	if destr_map is not DestroyableTileMapComponent:
		push_error("World Environment is Non-Destroyable. Attach DestroyableTileMapComponent")
	elif destr_map:
		_debug(2,self.name,'_ready()',destr_map.name)
		destr_map.smoke_started.connect(_on_smoke_started)
		destr_map.smoke_ended.connect(_on_smoke_ended)
	else:
		_debug(1,self.name,'_ready(), destr_map NOT NOT NOT found')

func _on_smoke_started(strength:int)->void:
	_debug(2,self.name,'smoke start ',strength)
	environment.glow_intensity += strength * glow_on_explosion_modifier

func _on_smoke_ended(strength:int)->void:
	_debug(1,self.name,'smoke end')
	environment.glow_intensity -= strength * glow_on_explosion_modifier

func _debug(ID:int, d=null, dy=null, dyn=null, dyna=null, dynam=null, dynami=null, dynamic=null)->void:
	if not debug: return
	match ID:
		0: print(d)
		1: print(d,dy)
		2: printt(d,dy,dyn)
