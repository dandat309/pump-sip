extends Control
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		click()

func click():
	print("Avançando para o jogo...")
	get_tree().change_scene_to_file("res://jogo.tscn")  # Troque pelo caminho da sua cena
