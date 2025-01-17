extends TextureProgressBar
var elapsed = 0.0
var starting_value = 100.0
var duration = 1.0
@onready var parent = get_parent()
#var grandparent = get_parent().get_parent()

func _ready(): set_process(false)
func _process(delta): make_it_happen(delta)
func _input(event):
	if event.is_action_pressed("ui_accept"):
		elapsed = 0.0
		value = starting_value
		if parent.name == "Bar6":
			set_process(true)

func make_it_happen(delta):
	set_process(false)
	elapsed += delta
	var proposed = int(starting_value *(1-(elapsed/duration)*(elapsed/duration)))
	if value != proposed:
		value = proposed
		print(value)
	printt('elapsed:', elapsed)
	printt('duration:', duration)
	if elapsed >= duration:
		value = 0
		print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		if get_parent().next != null:
			get_parent().next.begin()
		else:
			print(get_parent().get_parent())
		return
	set_process(true)
