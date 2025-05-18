extends Node2D
var tempo_restante = 0.0
var efeito_ativo = false

func _ready():
	atualizar_ui()
	get_node("/root/mainscreen")
func atualizar_ui():
	$energylabel.text = "Energia: " + str(JogoScript.energia)
	$Explabel.text = "Exp: " + str(JogoScript.experiencia)
	$Moneylabel.text = "Coin: " + str(JogoScript.dinheiro)
	$Contadorlabel.text = "Click: " + str(JogoScript.contador)
	$rebirthlabel.text = "Rebirth: " + str(JogoScript.rebirth)
	$nivellebal.text = "Lvl: " + str(JogoScript.nivel)
	if JogoScript.energia <= 0:
		$drinkButton.show()
	else:
		$drinkButton.hide()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		JogoScript.click()
		atualizar_ui()
		$inactivity.start()

func _on_loja_pressed():
	get_tree().change_scene_to_file("res://cenas/loja.tscn")

func _on_inactivity_timeout() -> void: 
	get_tree().change_scene_to_file("res://cenas/game_over.tscn")

func _on_drink_button_pressed() -> void:
	JogoScript.energia = 100
	atualizar_ui()
	$inactivity.start()
	$drinkButton.hide()

func iniciar_efeito(duracao):
	tempo_restante = duracao
	efeito_ativo = true
	$efeitolabel.show()
	
func _process(delta):
	if efeito_ativo:
		tempo_restante -= delta
		$efeitolabel.text = "Efeito ativo: %.1f s" % tempo_restante
		if tempo_restante <= 0:
			efeito_ativo = false
			$efeitolabel.hide()
