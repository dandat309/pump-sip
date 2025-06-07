extends Control

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		click()
func click():
	get_tree().change_scene_to_file("res://cenas/mainscreen.tscn")  
