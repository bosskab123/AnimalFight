extends Control

onready var snake_button = $VBoxContainer/HBoxContainer/snake_button
onready var wasp_button = $VBoxContainer/HBoxContainer/wasp_button
onready var frog_button = $VBoxContainer/HBoxContainer/frog_button
onready var rat_button = $VBoxContainer/HBoxContainer/rat_button
func _ready():
	snake_button.connect("pressed",self,"snake_button_pressed")
	wasp_button.connect("pressed",self,"wasp_button_pressed")
	frog_button.connect("pressed",self,"frog_button_pressed")
	rat_button.connect("pressed",self,"rat_button_pressed")
	pass
	
func _process(delta):
	
	pass
	
func snake_button_pressed():
	Game.character = "snake"
	Game.character_size = Game.snake_size
	get_tree().change_scene("res://scenes/world.tscn")
	
	pass
	
func wasp_button_pressed():
	Game.character = "wasp"
	Game.character_size = Game.wasp_size
	get_tree().change_scene("res://scenes/world.tscn")
	pass
	
func frog_button_pressed():
	Game.character = "frog"
	Game.character_size = Game.frog_size
	get_tree().change_scene("res://scenes/world.tscn")
	pass
	
func rat_button_pressed():
	Game.character = "rat"
	Game.character_size = Game.rat_size
	get_tree().change_scene("res://scenes/world.tscn")
	pass	
