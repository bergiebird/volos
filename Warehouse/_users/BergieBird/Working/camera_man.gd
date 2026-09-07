extends Camera2D
class_name CameraMan

signal start_level()
signal end_level()

const MAX_ZOOM_WIDTH: int = 40
const MAX_ZOOM_HEIGHT: int = 30
const MIN_ZOOM_WIDTH: int = 20
const MIN_ZOOM_HEIGHT: int = 15
const TILE_SIZE: int = 16
const ZOOM_SMOOTHING: float = 0.1
const BOARDSCENE: Resource = preload("res://Warehouse/_users/BergieBird/Working/the_board.tscn")

var is_zoomed_in: bool = false
var target_zoom: Vector2 = Vector2.ONE
var board_instance: Node = null
var swatch_red: Color = Color(0.337, 0.129, 0.165, 1)
var swatch_black: Color = Color(0.086,0.051,0.075,1)

@onready var current_zoom: Vector2 = target_zoom
@onready var cover: NinePatchRect = %GameCover
#@onready var go_here: Node2D = %LevelGoesHere
@onready var sfx_space: AudioStreamPlayer = $NonSpacebar
@onready var menu_rect: ColorRect = %RedColorRect


func _ready() -> void:
	Signalton.level_complete.connect(toggle_zoom)
	Signalton.level_lost.connect(toggle_zoom)
	start_level.connect(Levelton.on_level_over)
	end_level.connect(Levelton.on_level_over)
	var viewport_size: Vector2 = get_viewport_rect().size
	var initial_zoom: Vector2 = Vector2(viewport_size.x / (MAX_ZOOM_WIDTH * TILE_SIZE), viewport_size.y / (MAX_ZOOM_HEIGHT * TILE_SIZE))
	zoom = initial_zoom
	current_zoom = initial_zoom
	target_zoom = initial_zoom


func _process(_delta: float) -> void:
	current_zoom = current_zoom.lerp(target_zoom, ZOOM_SMOOTHING)
	zoom = current_zoom


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		sfx_space.play()
		toggle_zoom()


func toggle_zoom() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size
	is_zoomed_in = !is_zoomed_in
	if is_zoomed_in:
		menu_rect.set_color(swatch_black)
		cover.visible = false
		target_zoom = Vector2(
			viewport_size.x / (MIN_ZOOM_WIDTH * TILE_SIZE),
			viewport_size.y / (MIN_ZOOM_HEIGHT * TILE_SIZE))
		start_level.emit()
		#board_instance = BOARDSCENE.instantiate()
		#go_here.add_child(board_instance)
	else:
		menu_rect.set_color(swatch_red)
		cover.visible = true
		target_zoom = Vector2(
			viewport_size.x / (MAX_ZOOM_WIDTH * TILE_SIZE),
			viewport_size.y / (MAX_ZOOM_HEIGHT * TILE_SIZE))
		end_level.emit()
		#board_instance.queue_free()
		#board_instance = null
