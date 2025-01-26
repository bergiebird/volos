class_name ContentTab
extends Button

@export var index: int = -1
@export var total: int = -1

func _clicked():
	var i = 0
	while i < total:
		i += 1
		if i == index:
			get_parent().get_parent().get_parent().get_child(i).visible = true
		else:
			get_parent().get_parent().get_parent().get_child(i).visible = false
