extends TextureProgress

var bar_green = preload("res://assets/healthbar/barHorizontal_green.png")
var bar_yellow = preload("res://assets/healthbar/barHorizontal_yellow.png")
var bar_red = preload("res://assets/healthbar/barHorizontal_red.png")

func _ready():
	texture_progress = bar_green
	pass 
	
func update_bar(amount,full):
	value = amount
	if amount < 0.75 * full:
		texture_progress = bar_yellow
	if amount < 0.45 * full:
		texture_progress = bar_red
	pass
