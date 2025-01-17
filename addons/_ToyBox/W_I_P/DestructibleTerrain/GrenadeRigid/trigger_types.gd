extends Node
func what_trigger_type(trigger)->void:
	if trigger <= 1:   %TriggerDetonator.set_process_input(true)
	elif trigger == 2: %TriggerFuse.start_fuse()
	elif trigger == 3: %TriggerImpact.enable_impact()
