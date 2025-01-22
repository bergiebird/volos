extends Panel


@export var tile_sets: Array[TileSet]
const texture_rect: PackedScene = preload("res://ProjectVolos/Ryan/WIP/select_tile.tscn")
const tab: PackedScene = preload("res://ProjectVolos/Ryan/WIP/tilemap_tab.tscn")
const tab_content: PackedScene = preload("res://ProjectVolos/Ryan/WIP/tap_content.tscn")
var c_total: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for t in tile_sets:
		var c_start = t.get_source_count()
		c_total += c_start
		var c = c_start
		while c > 0:
			c -= 1
			var atlas = t.get_source(c) as TileSetAtlasSource
			var count = atlas.get_tiles_count()
			var name_of_file = atlas.texture.resource_path.get_file().get_slice(".", 0)
			var light_durection = name_of_file.split("-")[name_of_file.get_slice_count("-") - 1].to_lower()
			if light_durection == "n" or light_durection == "ne" or light_durection == "e" or light_durection == "se" or light_durection == "s" or light_durection == "sw" or light_durection == "w" or light_durection == "nw" or light_durection == "dark":
				c_total -= 1;
				continue
			
			var tab_instance = tab.instantiate() as Button
			tab_instance.text = " ".join(name_of_file.split("-"))
			self.get_child(0).get_child(0).add_child(tab_instance)
			
			var tab_content_instance = tab_content.instantiate()
			tab_content_instance.position += Vector2(320, 65)
			if c_total - c > 1:
				tab_content_instance.visible = false
			self.add_child(tab_content_instance)

			print(c_total - c)
			while count > 0:
				count -= 1
				var coord = atlas.get_tile_id(count)
				var instance = texture_rect.instantiate()
				instance.texture_normal = get_cell_texture(coord, atlas)
				instance.index = count
				instance.tap_content_index = c_total - c
				instance.coords = coord
				instance.tab = " ".join(name_of_file.split("-"))
				self.get_child(c_total - c).get_child(0).add_child(instance)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func get_cell_texture(coord: Vector2i, source: TileSetAtlasSource) -> Texture:
	var rect := source.get_tile_texture_region(coord)
	var image: Image = source.texture.get_image()
	var tile_image := image.get_region(rect)
	return ImageTexture.create_from_image(tile_image)
