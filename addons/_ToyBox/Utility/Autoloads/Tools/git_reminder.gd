@tool
extends Node # git_reminder.gd
# Don't give me a class name, I'm a Global signal

var start_time
var marker1
var marker2

func _ready():
	#vrood_dir_test()
	if not Engine.is_editor_hint(): queue_free()

	start_time = Time.get_datetime_dict_from_system()
	marker1 = start_time.minute + 45
	marker2 = marker1 + 30
	if marker1 >= 60: marker1 -= 60
	if marker2 >= 60: marker2 -= 60

func _process(_delta: float) -> void:
	var time = Time.get_datetime_dict_from_system()
	if time.minute == marker1 or time.minute == marker2:
		if time.second < 0.5:
			print_rich("[color=red][pulse]SAVE YOUR WORK SAVE YOUR WORK SAVE YOUR WORK COMMIT COMMIT COMMIT[/pulse][/color]")



#func vrood_dir_test():
	#var path = OS.get_environment("USERPROFILE") + "/Desktop/VroodWasHere"
	#DirAccess.make_dir_recursive_absolute(path)
	#OS.shell_open(path)
