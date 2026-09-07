extends Node2D
class_name LevelGoesHere


@export var choose_your_level: PackedScene
@export var tutorial_stuff: PackedScene

var current_active_level: Node
var tutorial_node: Node


func _ready() -> void:
	tutorial_node = tutorial_stuff.instantiate()
	add_child(tutorial_node)


func _on_level_selector_new_level(tscn: PackedScene) -> void:
	choose_your_level = tscn


func _on_camera_man_v_2_start_level() -> void:
	if tutorial_node:
		tutorial_node.queue_free()
	current_active_level = choose_your_level.instantiate()
	add_child.call_deferred(current_active_level)


func _on_camera_man_v_2_end_level() -> void:
	current_active_level.queue_free()
	current_active_level = null
	tutorial_node = tutorial_stuff.instantiate()
	add_child.call_deferred(tutorial_node)
