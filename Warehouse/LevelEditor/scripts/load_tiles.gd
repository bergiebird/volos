extends Panel


@export var tile_sets: Array[TileSet]
const texture_rect: PackedScene = preload("res://ProjectVolos/_Main_Scenes/LevelEditor/select_tile.tscn")
const tab: PackedScene = preload("res://ProjectVolos/_Main_Scenes/LevelEditor/tilemap_tab.tscn")
const tab_content: PackedScene = preload("res://ProjectVolos/_Main_Scenes/LevelEditor/tap_content.tscn")
var total_count: int = 1
var string_array: Array[String] = ["n", "ne", "e", "se", "s", "sw", "w", "nw", "dark"]
var terrain_array: Array[int]
var tab_array: Array[String]

func _ready():
	for child in get_parent().get_parent().get_child(1).get_children():
		if tile_sets.has(child.get_tile_set()) == false:
			tile_sets.append(child.get_tile_set())

	var tile_set_index = 0
	for tileset in tile_sets:
		terrain_array.clear()
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
			var us_tab = total_count
			if tab_array.has(" ".join(name_of_file.split("-"))):
				us_tab = tab_array.find(" ".join(name_of_file.split("-"))) + 2
				total_count -= 1
			else:
				var tab_instance = tab.instantiate() as ContentTab
				tab_array.append(" ".join(name_of_file.split("-")))
				tab_instance.text = " ".join(name_of_file.split("-"))
				tab_instance.index = us_tab
				self.get_child(0).get_child(0).add_child(tab_instance)

				var tab_content_instance = tab_content.instantiate()
				tab_content_instance.position += Vector2(320, 65)
				if us_tab > 1:
					tab_content_instance.visible = false
				self.add_child(tab_content_instance)

			#print(us_tab)
			while atlas_count > 0:
				atlas_count -= 1
				var coord = atlas.get_tile_id(atlas_count)
				var terrain_id = atlas.get_tile_data(coord, 0).terrain
				if terrain_array.has(terrain_id) == false and atlas.get_tile_data(coord, 0).terrain != -1:
					terrain_array.append(terrain_id)
					var instance = texture_rect.instantiate()
					instance.texture_normal = get_cell_texture(coord, atlas)
					instance.index = starting_count
					instance.layer_index = tile_set_index
					instance.tap_content_index = us_tab
					instance.terrain_index = terrain_id
					instance.coords = coord
					instance.tab = " ".join(name_of_file.split("-"))
					self.get_child(1).get_child(0).add_child(instance)
				elif atlas.get_tile_data(coord, 0).terrain == -1:
					if !atlas.has_tile(coord): print(atlas.has_tile(coord))
					var instance = texture_rect.instantiate()
					instance.texture_normal = get_cell_texture(coord, atlas)
					instance.index = starting_count
					instance.layer_index = tile_set_index
					instance.tap_content_index = us_tab
					instance.coords = coord
					instance.tab = " ".join(name_of_file.split("-"))
					self.get_child(us_tab).get_child(0).add_child(instance)
		tile_set_index += 1
	for child in self.get_child(0).get_child(0).get_children():
		child.total = total_count


func get_cell_texture(coord: Vector2i, source: TileSetAtlasSource) -> Texture:
	var rect := source.get_tile_texture_region(coord)
	var image: Image = source.texture.get_image()
	var tile_image := image.get_region(rect)
	return ImageTexture.create_from_image(tile_image)
