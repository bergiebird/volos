extends Button
var combat_action:CombatAction
@onready var target = get_node("/root/TBCscene")

func _ready():
	if not target: print('no target')
	disabled = true
func _on_pressed()->void:
	if target and target.cur_char and target.cur_char.is_player:
		if not disabled:
			target.cur_char.cast_combat_action(combat_action)
	printt(target,"target")
	printt(target.cur_char,"target.cur_char")
