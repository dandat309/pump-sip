extends Node2D

func _ready():
	atualizar_ui()

func atualizar_ui():
	$energylabel.text = "Energia: " + str(JogoScript.energia)
	$Explabel.text = "Exp: " + str(JogoScript.experiencia)
	$Moneylabel.text = "Coin: " + str(JogoScript.dinheiro)
	$Contadorlabel.text = "Click: " + str(JogoScript.contador)
	$rebirthlabel.text = "Rebirth: " + str(JogoScript.rebirth)
	$nivellebal.text = "Lvl: " + str(JogoScript.nivel)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		JogoScript.click()
		atualizar_ui()

func _on_loja_pressed():
	get_tree().change_scene_to_file("res://cenas/loja.tscn")
