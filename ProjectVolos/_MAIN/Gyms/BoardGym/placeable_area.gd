class_name PlaceableArea
extends Area2D # placeable_area.gd
# Purpose: Be a monitorable area for the Focus.tscn

const COL_LAYER = 8
const MONITORING = false
const MONITORABLE = true

var area_enabled:bool=true: get = is_area_enabled, set = set_area_enabled

signal placeable_area_enabled(area_enabled)

func _ready()->void:
	set_collision_layer_value(COL_LAYER, true)
	set_monitoring(MONITORING)
	set_monitorable(MONITORABLE)

func is_area_enabled()->bool:
	return area_enabled

func set_area_enabled(val:bool)->void:
	area_enabled = val
	placeable_area_enabled.emit(area_enabled)
