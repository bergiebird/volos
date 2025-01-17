extends Sprite2D

@onready var scale_sprite_component: ScaleSpriteComponent = $ScaleSpriteComponent

func _on_scale_button_pressed()->void:
	scale_sprite_component.tween_scale()
