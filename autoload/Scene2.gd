extends Control

func _ready():
	pass

func _on_Button_pressed():
	get_node("/root/global").go_to_scene(("res://Scene1.tscn"))
