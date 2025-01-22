extends TileButton

func _clicked():
	var node = get_parent().get_parent().get_parent().get_parent().get_child(1)
	node.texture = texture_normal
	node.index = index
	node.tap_content_index = tap_content_index
	node.coords = coords
	node.tab = tab
