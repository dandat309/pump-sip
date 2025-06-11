extends Node2D

func _process(_delta):
	atualizar_ui()
	
func _on_whey_pressed() -> void:
	if JogoScript.gastar_dinheiro(300):
		JogoScript.usar_whey()
		atualizar_ui()
		await get_tree().create_timer(10).timeout
		JogoScript.reset_efeitos()
		atualizar_ui()

func _on_creatina_pressed() -> void:
	if JogoScript.gastar_dinheiro(500):
		JogoScript.usar_creatina()
		atualizar_ui()
		await get_tree().create_timer(10).timeout
		JogoScript.reset_efeitos()
		atualizar_ui()


func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/mainscreen.tscn")

func atualizar_ui() -> void:
	print(JogoScript.dinheiro)
