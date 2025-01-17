extends VBoxContainer #player_ui.gd
@export var buttons:Array
@onready var elder = get_parent().get_parent()

func _ready():
	SignalTown.begin_turn.connect(_on_turn_began)
	SignalTown.end_turn.connect(_on_turn_ended)

func _on_turn_began(character):
	if character.is_player:
		_display_combat_actions(character.combat_actions)

func _on_turn_ended(character):
	visible = false
	for button_path in buttons:
		var button = get_node(button_path)
		button.disabled = true

func _display_combat_actions(combat_actions):
	visible = true
	for i in len(buttons):
		var button = get_node(buttons[i])
		if i < len(combat_actions):
			button.visible = true
			button.disabled = false
			button.text = combat_actions[i].display_name
			button.combat_action = combat_actions[i]
		else:
			button.visible = false
			button.disabled = true
