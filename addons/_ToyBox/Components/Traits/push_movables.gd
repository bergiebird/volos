@icon("res://addons/_ToyBox/Icons/node_2D/icon_puzzle.png")
class_name PushMovablesTrait
extends Node

#region Export Params
@export_range(5.0, 100.0, 5.0, "or_greater") var push_force: float = 50.0
@export var is_enabled: bool = true
@export var parent_body: CharacterBody2D
#endregion


func _physics_process(_delta: float) -> void:
	if not is_enabled: return
	for i in parent_body.get_slide_collision_count():
		var collision: KinematicCollision2D = parent_body.get_slide_collision(i)
		var collider: MovableRigidBody2D = collision.get_collider() as RigidBody2D
		if collider: collider.apply_central_impulse(-collision.get_normal() * push_force)
