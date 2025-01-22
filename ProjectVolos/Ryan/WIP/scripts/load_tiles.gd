extends Panel


@export var tile_sets: Array[TileSet]
const texture_rect: PackedScene = preload("res://ProjectVolos/Ryan/WIP/select_tile.tscn")
const tab: PackedScene = preload("res://ProjectVolos/Ryan/WIP/tilemap_tab.tscn")
const tab_content: PackedScene = preload("res://ProjectVolos/Ryan/WIP/tap_content.tscn")
var total_count: int = 0
var string_array: Array[String] = ["n", "ne", "e", "se", "s", "sw", "w", "nw", "dark"]

func _ready():
	for child in get_parent().get_parent().get_child(1).get_children():
		if tile_sets.has(child.get_tile_set()) == false:
			tile_sets.append(child.get_tile_set())
	
	var tile_set_index = 0
	for tileset in tile_sets:
		var starting_count = tileset.get_source_count()
		while starting_count > 0:
			starting_count -= 1
			var atlas = tileset.get_source(starting_count) as TileSetAtlasSource
			var atlas_count = atlas.get_tiles_count()
			var name_of_file = atlas.texture.resource_path.get_file().get_slice(".", 0)
			var light_durection = name_of_file.split("-")[name_of_file.get_slice_count("-") - 1].to_lower()
			
			var whatever = false
			for st in string_array:
				if light_durection == st:
					whatever = true
			
			if whatever:
				continue

			total_count += 1

			'''
			if light_durection == "n" or light_durection == "ne" or light_durection == "e" or light_durection == "se" or light_durection == "s" or light_durection == "sw" or light_durection == "w" or light_durection == "nw" or light_durection == "dark":
				total_count -= 1
				continue
			'''

			var tab_instance = tab.instantiate() as ContentTab
			tab_instance.text = " ".join(name_of_file.split("-"))
			tab_instance.index = total_count
			self.get_child(0).get_child(0).add_child(tab_instance)

			var tab_content_instance = tab_content.instantiate()
			tab_content_instance.position += Vector2(320, 65)
			if total_count > 1:
				tab_content_instance.visible = false
			self.add_child(tab_content_instance)

			print(total_count)
			while atlas_count > 0:
				atlas_count -= 1
				var coord = atlas.get_tile_id(atlas_count)
				var instance = texture_rect.instantiate()
				instance.texture_normal = get_cell_texture(coord, atlas)
				instance.index = starting_count
				instance.layer_index = tile_set_index
				instance.tap_content_index = total_count
				instance.coords = coord
				instance.tab = " ".join(name_of_file.split("-"))
				self.get_child(total_count).get_child(0).add_child(instance)
		tile_set_index += 1
	for child in self.get_child(0).get_child(0).get_children():
		child.total = total_count


func get_cell_texture(coord: Vector2i, source: TileSetAtlasSource) -> Texture:
	var rect := source.get_tile_texture_region(coord)
	var image: Image = source.texture.get_image()
	var tile_image := image.get_region(rect)
	return ImageTexture.create_from_image(tile_image)
