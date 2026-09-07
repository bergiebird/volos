extends TileButton

func _clicked():
	var node = get_parent().get_parent().get_parent().get_parent().get_child(1)
	var level = get_parent().get_parent().get_parent().get_parent().get_parent().get_child(1)
	var child_index = 0
	for child in level.get_children():
		if layer_index >= child_index:
			child.modulate.a = 1
		else:
			child.modulate.a = 0.2
		child_index += 1
	node.get_parent().get_parent().get_child(0).texture = texture_normal
	node.texture = texture_normal
	node.index = index
	node.layer_index = layer_index
	node.tap_content_index = tap_content_index
	node.terrain_index = terrain_index
	node.coords = coords
	node.tab = tab
