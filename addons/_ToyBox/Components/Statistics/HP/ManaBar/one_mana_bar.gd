extends NinePatchRect
@export var next: NinePatchRect = null

func _ready():
	get_child(0).set_name(get_name())
func begin():
	get_child(0).set_process(true)
