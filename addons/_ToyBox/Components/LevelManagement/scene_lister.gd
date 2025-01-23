@tool
extends Node
class_name SceneLister
## Helper class for listing all the scenes in a level_directory.

## Prefilled in the editor by selecting a level_directory.
@export var scene_files : Array[String]

## Prefill scene_files with any scenes in the level_directory.
@export_dir var level_directory : String :
	set(value):
		level_directory = value
		_refresh_scene_files()

func _refresh_scene_files():
	if not is_inside_tree() or level_directory.is_empty(): return
	var dir_access = DirAccess.open(level_directory)
	if dir_access:
		scene_files.clear()
		for file in dir_access.get_scene_files():
			if not file.ends_with(".tscn"):
				continue
			scene_files.append(level_directory + "/" + file)
