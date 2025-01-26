@icon("res://addons/_ToyBox/Icons/misc/drag.png") extends Node
class_name GridMovement

@export var tile_size: int = 16
@export var moves_per_second: float = .1

@export_group("DEBUG")
@export var debug_all: bool = false
@export var debug_ready: bool = false
@export var debug_process: bool = false
@export var debug_input: bool = false
@export var debug_movement: bool = false
@export var debug_selection: bool = false
var can_move: bool = true
var parent: CharacterBody2D
var is_selected: bool = false
var selection_indicator: Node2D
static var selected_units: Array[GridMovement] = []

func _ready():
	parent = get_parent()
	setup_selection_indicator()
	setup_input_handling()
	setup_character_group()

func _unhandled_input(event):
	if not is_selected or not can_move:
		return
	var _direction = Vector2.ZERO
	if event.is_action_pressed("kog_up"):
		_direction = Vector2.UP
	elif event.is_action_pressed("kog_down"):
		_direction = Vector2.DOWN
	elif event.is_action_pressed("kog_left"):
		_direction = Vector2.LEFT
	elif event.is_action_pressed("kog_right"):
		_direction = Vector2.RIGHT
	if _direction != Vector2.ZERO:
		move(_direction)
	if event.is_action_pressed("ui_accept"):
		deselect_all()

func setup_selection_indicator():
	selection_indicator = create_default_selection_indicator()
	selection_indicator.visible = false
	parent.call_deferred("add_child", selection_indicator)

func create_default_selection_indicator()->Node2D:
	var _sprite = Sprite2D.new()
	_sprite.texture = preload("res://addons/_ToyBox/Icons/misc/icons8-exclamation-mark-100.png")
	_sprite.scale = Vector2(0.1, 0.1)
	_sprite.position = Vector2(tile_size / 2, tile_size / 2)
	return _sprite

func setup_input_handling():
	set_process_unhandled_input(false)
	if parent.has_signal("input_event"):
		parent.input_event.connect(_on_input_event)

func setup_character_group():
	if not parent.is_in_group("selectable_characters"):
		parent.add_to_group("selectable_characters")

func move(_direction: Vector2):
	var _target_position = parent.global_position + _direction * tile_size
	var _space_state = parent.get_world_2d().direct_space_state
	var _query = PhysicsRayQueryParameters2D.create(parent.global_position, _target_position)
	_query.collision_mask = 1
	_query.collide_with_bodies = true
	_query.collide_with_areas = true
	var _result = _space_state.intersect_ray(_query)
	if _result.is_empty():
		parent.global_position = _target_position
		can_move = false
		await get_tree().create_timer(moves_per_second).timeout
		can_move = true

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				select()
func select():
	if is_selected: return
	is_selected = true
	show_selection_indicator()
	set_process_unhandled_input(true)
	selected_units.append(self)
func deselect_all():
	var _units = selected_units.duplicate()
	for unit in _units:
		unit.deselect()
	selected_units.clear()
func deselect():
	is_selected = false
	hide_selection_indicator()
	set_process_unhandled_input(false)
	selected_units.erase(self)
func show_selection_indicator(): if selection_indicator: selection_indicator.visible = true
func hide_selection_indicator(): if selection_indicator: selection_indicator.visible = false
func set_custom_selection_indicator(new_indicator: Node2D):
	if selection_indicator: selection_indicator.queue_free()
	selection_indicator = new_indicator
	selection_indicator.visible = is_selected
	parent.add_child(selection_indicator)
