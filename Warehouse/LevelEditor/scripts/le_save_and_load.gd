extends Control

@export var info_node: TextureRect
var file_name: String = "UNNAMED"
var first_save: bool = true
var playable_area: Array[Vector2i]
var parterns: Array[TileMapPattern]

func _ready():
	get_parent().get_parent().get_child(1).updated_file.connect(_file_change)
	var x = 0
	while x < 16:
		var y = 0
		while y < 12:
			playable_area.append(Vector2i(x, y))
			y += 1
		x += 1

func _save():
	parterns.clear()
	first_save = false
	get_child(2).text = file_name + ".lvl"

	if file_name == "" and first_save == false:
		get_child(1).get_child(0).get_child(0).text = "It can't be named that"
		return
	
	for layer in get_parent().get_parent().get_child(1).get_children():
		parterns.append(layer.get_pattern(playable_area))

	if OS.get_name() == "Web":
		JavaScriptBridge.download_buffer(var_to_bytes_with_objects(parterns), file_name + ".lvl")
	
	var file = FileAccess.open("user://" + file_name + ".lvl", FileAccess.WRITE)
	file.store_buffer(var_to_bytes_with_objects(parterns))

func _save_menu():
	if first_save:
		get_child(1).get_child(0).get_child(0).text = "Save"
		get_child(1).get_child(0).get_child(1).text = ""
		get_child(1).visible = true
		get_child(1).get_child(0).get_child(2).visible = true
		get_child(1).get_child(0).get_child(3).visible = false
	else:
		_save()

func _save_as_menu():
	get_child(1).get_child(0).get_child(0).text = "Save As"
	get_child(1).get_child(0).get_child(1).text = ""
	get_child(1).visible = true
	get_child(1).get_child(0).get_child(2).visible = true
	get_child(1).get_child(0).get_child(3).visible = false

func _load_menu():
	get_child(1).get_child(0).get_child(0).text = "Load"
	get_child(1).get_child(0).get_child(1).text = ""
	get_child(1).visible = true
	get_child(1).get_child(0).get_child(3).visible = true
	get_child(1).get_child(0).get_child(2).visible = false

func _save_as():
	file_name = get_child(1).get_child(0).get_child(1).text.get_slice(".", 0).to_upper()
	

	if file_name.contains("/"):
		get_child(1).get_child(0).get_child(0).text = "Can't contain a / "
		return
	elif file_name == "":
		get_child(1).get_child(0).get_child(0).text = "Name can't be blank"
		return
	_save()
	get_child(1).visible = false

func _load():
	file_name = get_child(1).get_child(0).get_child(1).text.get_slice(".", 0).to_upper()
	
	if not FileAccess.file_exists("user://" + file_name + ".lvl"):
		get_child(1).get_child(0).get_child(0).text = "File does not exist"
		return
	
	get_child(2).text = file_name + ".lvl"

	var file = FileAccess.open("user://" + file_name + ".lvl", FileAccess.READ) as FileAccess

	var bytes = file.get_buffer(file.get_length())
	print("Bytes loaded: ", bytes.size())

	var pattern = bytes_to_var_with_objects(bytes) as Array[TileMapPattern]
	print("Pattern created: ", pattern)
	# print("Pattern size: ", pattern.get_size() if pattern else "null")

	var layer_index = 0
	for layer in get_parent().get_parent().get_child(1).get_children():
		layer.set_pattern(Vector2i(0, 0), pattern[layer_index])
		layer_index += 1
	get_child(1).visible = false

func _upload():
	file_name = get_child(1).get_child(0).get_child(1).text.get_slice(".", 0).to_upper()
	print(Supabase.storage.from("Volos_Levels"))

	if not FileAccess.file_exists("user://" + file_name + ".lvl"):
		return
	
	var response = Supabase.storage.from("Volos_Levels").upload(file_name + ".lvl", "user://" + file_name + ".lvl")
	if response['error'] == null:
		print('Upload successful!')
	else:
		print('Upload failed: ', response['error'])

func _close_menu():
	get_child(1).visible = false

func _file_change():
	print("*" + file_name + ".lvl")
	get_child(2).text = "*" + file_name + ".lvl"
