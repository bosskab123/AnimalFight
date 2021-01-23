extends Control

onready var test = $VBoxContainer/test_button
onready var story = $VBoxContainer/story_button
onready var multi = $VBoxContainer/multiplayer_button

func _ready():
	test.connect("mouse_entered",self,"test_mouse_entered")
	test.connect("pressed",self,"test_pressed")
	story.connect("mouse_entered",self,"story_mouse_entered")
	story.connect("pressed",self,"story_pressed")
	multi.connect("mouse_entered",self,"multi_mouse_entered")
	multi.connect("pressed",self,"multi_pressed")
	pass

func test_mouse_entered():
	pass
	
func test_pressed():
	get_tree().change_scene("res://scenes/select_character.tscn")
	pass
	
func story_mouse_entered():
	pass
	
func story_pressed():
	get_tree().change_scene("res://scenes/select_character.tscn")
	pass
	
func multi_mouse_entered():
	pass
	
func multi_pressed():
	get_tree().change_scene("res://scenes/select_character.tscn")
	pass
