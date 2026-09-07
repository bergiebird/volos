extends Node2D
class_name TutControls

@export var label_w: Label
@export var label_e: Label
@export var label_s: Label
@export var label_a: Label
@export var label_d: Label

@export var label_i: Label
@export var label_j: Label
@export var label_k: Label
@export var label_l: Label


@onready var pressed_font: = preload("uid://duaa435o2cwak")
@onready var idle_font: = preload("uid://53yvsagn4cwe")

func _input(event: InputEvent) -> void:
	# KOG
	if event.is_action_pressed(&"kog_up"):
		label_w.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"kog_up"):
		label_w.add_theme_font_override(&'font', idle_font)
	if event.is_action_pressed(&"kog_down"):
		label_s.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"kog_down"):
		label_s.add_theme_font_override(&'font', idle_font)
	if event.is_action_pressed(&"kog_left"):
		label_a.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"kog_left"):
		label_a.add_theme_font_override(&'font', idle_font)
	if event.is_action_pressed(&"kog_right"):
		label_d.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"kog_right"):
		label_d.add_theme_font_override(&'font', idle_font)
	if event.is_action_pressed(&"kog_charge"):
		label_e.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"kog_charge"):
		label_e.add_theme_font_override(&'font', idle_font)
	# CLEP
	if event.is_action_pressed(&"loot_up"):
		label_i.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"loot_up"):
		label_i.add_theme_font_override(&'font', idle_font)
	if event.is_action_pressed(&"loot_left"):
		label_j.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"loot_left"):
		label_j.add_theme_font_override(&'font', idle_font)
	if event.is_action_pressed(&"loot_right"):
		label_l.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"loot_right"):
		label_l.add_theme_font_override(&'font', idle_font)
	if event.is_action_pressed(&"loot_down"):
		label_k.add_theme_font_override(&'font',pressed_font)
	elif event.is_action_released(&"loot_down"):
		label_k.add_theme_font_override(&'font', idle_font)
