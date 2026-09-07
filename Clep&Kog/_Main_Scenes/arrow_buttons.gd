extends Area2D
class_name ArrowButton

signal clicked()

enum Direction {LEFT, RIGHT}

@export var which_direction: Direction
@export var sprite: AnimatedSprite2D
@export var sfx: AudioStreamPlayer

var is_mouse_entered: bool

func _ready() -> void:
	match which_direction:
		Direction.LEFT:
			sprite.animation = &"left"
			sfx.pitch_scale = 1.9
		Direction.RIGHT:
			sprite.animation = &"right"
			sfx.pitch_scale = 2.0
	sprite.stop()
	input_pickable = true
	input_event.connect(_on_input_event)
	mouse_exited.connect(_on_mouse_exited)


func _on_input_event(_vp: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed(&"left_click"):
		clicked.emit()
		sprite.frame = 1
		sfx.play()
	elif event.is_action_released(&"left_click"):
		sprite.frame = 0


func _on_mouse_exited() -> void:
	sprite.frame = 0
