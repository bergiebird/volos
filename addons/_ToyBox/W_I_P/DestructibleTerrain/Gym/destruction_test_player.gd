extends CharacterBody2D
@export var speed:float = 100.0
@export var acceleration:float = 50.0
@export var jump_force:float = 400.0
@export var debug:bool = false
@onready var anim:AnimatedSprite2D = $AnimatedSprite2D
