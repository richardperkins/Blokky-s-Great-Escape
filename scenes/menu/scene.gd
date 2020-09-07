extends Control

export(String) var scene
var scene_dir = "res://scenes/"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_scene():
	get_tree().change_scene("res://scenes/levels/level1.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/levels/level1.tscn")
