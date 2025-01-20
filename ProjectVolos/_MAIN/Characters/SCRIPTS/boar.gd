@icon("res://addons/_ToyBox/Icons/color/icon_weapon.png")
class_name TheBoar # boar.gd
extends TileBasedEntity

@export var max_range := 500
@export var move_rate := 5
@export var initial_direction := Vector2.RIGHT
var moving :bool = false
var current_direction :Vector2
var tween :Tween
var can_charge:bool= true
@onready var ray :RayCast2D = $RayCast2D
@onready var focus: FocusTile = %Focus
@onready var shader_rect: ShaderRect = $"../CanvasLayer/ShaderRect"
var score: int

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		position = focus.global_position

func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	if not can_charge:
		return
	if event.is_action_pressed("charge"):
		move_tiles(initial_direction, max_range)
		can_charge = false

func move_tiles(direction: Vector2, tiles: int)->void:
	update_current(direction)
	if ray.is_colliding() and tween:
		await tween.finished
		tween.kill()
	for m in range(max_range):
		update_current(direction)
		if ray.is_colliding():
			await tween.finished
			tween.kill()
		tween = create_tween()
		moving = true
		tween.tween_property(self, "position",
				position + direction * tile_size,
				1.0/move_rate).set_trans(Tween.TRANS_SINE)
		await tween.finished
		moving = false

func _on_area_entered(character:TileBasedEntity)->void:
	if character is BreakableTile:
		NodeRemover.remove(character)
		score += 1
		printt("Score:", score)

func update_current(direction)->void:
	current_direction = direction
	ray.target_position = current_direction * tile_size * 1.2
	ray.force_raycast_update()

func trample(character)->void:
	#character.die()
	NodeRemover.remove(character)

func shove(character)->void:
	#character.get_shoved()
	character.global_position += current_direction.orthogonal() * tile_size #move to side
