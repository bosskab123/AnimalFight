extends CanvasLayer

onready var timer = $timer
onready var label = $HBoxContainer/VBoxContainer/numeric_time

func _ready():
	label.set_text(str(Game.time))
	timer.one_shot = true
	timer.wait_time = Game.time
	set_process(false)
	pass
	
func _process(delta):
	label.set_text(str(int(timer.time_left)))
	if timer.is_stopped():
		_timeout()
	pass

func _input(event):
	if event.is_action_pressed("start_button"):
		set_process(true)
		timer.start()

func _timeout():
	get_tree().reload_current_scene()
	pass
