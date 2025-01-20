class_name PlaceableArea
extends Area2D
# placeable_area.gd
# Purpose: Be a monitorable area for the Focus.tscn
# Important that collision layer = 8 = "placeable"
# Important that monitoring = false, monitorable = on
signal placeable_area_enabled(area_enabled)

var area_enabled:bool=true:
	get = is_area_enabled, set = set_area_enabled

func is_area_enabled()->bool: return area_enabled
func set_area_enabled(val:bool)->void:
	area_enabled = val
	placeable_area_enabled.emit(area_enabled)
