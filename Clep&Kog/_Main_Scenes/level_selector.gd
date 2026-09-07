extends Node2D
class_name LevelSelector

signal new_level(tscn: PackedScene)

@export var levels: Array[PackedScene]
@export var level_label: Label
var names: Array[String]
var index: int:
	set(v):
		if v > levels.size() - 1:
			index = 0
		elif v < 0:
			index = levels.size() - 1
		else:
			index = v
		current_selected_level = {names[index]: levels[index]}

var current_selected_level: Dictionary[String, PackedScene]:
	set(v):
		current_selected_level = v
		var level_name: String = current_selected_level.keys()[0]
		level_label.text = level_name
		new_level.emit(current_selected_level[level_name])


func _ready() -> void:
	$LeftArrow.clicked.connect(_on_left_arrow_clicked)
	$RightArrow.clicked.connect(_on_right_arrow_clicked)
	for level: PackedScene in levels:
		names.append(level.get_state().get_node_name(0))
	current_selected_level = {
		names[0]: levels[0]}


func _on_left_arrow_clicked() -> void:
	index -= 1


func _on_right_arrow_clicked() -> void:
	index += 1


func _on_camera_man_v_2_start_level() -> void:
	visible = false


func _on_camera_man_v_2_end_level() -> void:
	visible = true
