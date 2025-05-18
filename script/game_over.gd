extends Control


func _on_button_pressed() -> void:
	var nivel_salvo = JogoScript.nivel  
	var rebirth_salvo = JogoScript.rebirth
	
	JogoScript.dinheiro = 0
	JogoScript.energia = 100
	JogoScript.contador = 0
	JogoScript.experiencia = 0
	JogoScript.rebirth = 0
	JogoScript.maxexp = 200
	JogoScript.modexp = 1
	JogoScript.consuenergia = 1
	
	JogoScript.nivel = nivel_salvo
	JogoScript.rebirth = rebirth_salvo
	get_tree().change_scene_to_file("res://cenas/mainscreen.tscn")
