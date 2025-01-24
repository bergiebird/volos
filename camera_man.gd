extends Camera2D #camera_man.gd

const MAX_ZOOM_WIDTH := 40
const MAX_ZOOM_HEIGHT := 30
const MIN_ZOOM_WIDTH := 20
const MIN_ZOOM_HEIGHT := 15
const TILE_SIZE := 16
const ZOOM_SMOOTHING := 0.1
var is_zoomed_in := false
var target_zoom := Vector2.ONE
var current_zoom := Vector2.ONE

func _ready():
	var viewport_size :Vector2 = get_viewport_rect().size
	var initial_zoom :Vector2 = Vector2(viewport_size.x / (MAX_ZOOM_WIDTH * TILE_SIZE), viewport_size.y / (MAX_ZOOM_HEIGHT * TILE_SIZE))
	zoom = initial_zoom
	current_zoom = initial_zoom
	target_zoom = initial_zoom

func _process(_delta):
	current_zoom = current_zoom.lerp(target_zoom, ZOOM_SMOOTHING)
	zoom = current_zoom

func toggle_zoom():
	var viewport_size :Vector2 = get_viewport_rect().size
	is_zoomed_in = !is_zoomed_in
	if is_zoomed_in:
		target_zoom = Vector2(
			viewport_size.x / (MIN_ZOOM_WIDTH * TILE_SIZE),
			viewport_size.y / (MIN_ZOOM_HEIGHT * TILE_SIZE))
	else:
		target_zoom = Vector2(
			viewport_size.x / (MAX_ZOOM_WIDTH * TILE_SIZE),
			viewport_size.y / (MAX_ZOOM_HEIGHT * TILE_SIZE))

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		toggle_zoom()
