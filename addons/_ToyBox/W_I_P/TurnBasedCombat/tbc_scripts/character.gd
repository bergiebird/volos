extends Node2D
class_name Character #character.gd

@export var cur_hp:int = 25
@export var max_hp:int = 25
@export var combat_actions:Array[CombatAction]
@export var opponent:Node
@export var flip:bool = false
@export var sf:SpriteFrames = null
@export var is_player:bool
@onready var health_bar:ProgressBar = %HealthBar
@onready var health_text:Label = %HealthText
@onready var anim_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var elder:Node2D = get_parent().get_parent()

func _ready():
	SignalTown.begin_turn.connect(_on_character_begun_turn)
	await get_tree().create_timer(1.5).timeout
	_set_health_bar()
	_set_animations()

func _set_health_bar():
	health_bar.value = cur_hp
	health_bar.max_value = max_hp

func _set_animations():
	if sf:
		anim_sprite.sprite_frames = sf
	anim_sprite.play()
	anim_sprite.flip_h = flip

func _update_health_bar():
	health_bar.value = cur_hp
	health_text.text = str(cur_hp, "/", max_hp)

func take_damage(damage):
	cur_hp -= damage
	_update_health_bar()
	if cur_hp <= 0:
		SignalTown.emit_signal("character_died", self)
		initiate_death_sequence()

func heal(amount):
	cur_hp += amount
	if cur_hp > max_hp:
		cur_hp = max_hp

func initiate_death_sequence():
	queue_free()

func cast_combat_action(action):
	print(action.damage)
	if action.damage > 0:
		opponent.take_damage(action.damage)
	if action.heal > 0:
		heal(action.heal)
	SignalTown.emit_signal("end_turn", self)

func _decide_combat_action():
	cast_combat_action(combat_actions.pick_random())

func _on_character_begun_turn(character):
	character._update_health_bar()
	if not character.is_player:
		_decide_combat_action()
		await get_tree().create_timer(1.5).timeout
		_update_health_bar()
