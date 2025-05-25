extends Node2D

var tempo_restante = 0.0
var efeito_ativo = false

@onready var barraC = %BarraClique
@onready var barraE = %energibar
@onready var barraexp = %barraexp

func _ready():
	atualizar_ui()
	get_node("/root/mainscreen")
	barraexp.max_value = JogoScript.maxexp
	barraexp.value = JogoScript.experiencia

func atualizar_ui():
	$energylabel.text = "Energia: " + str(JogoScript.energia)
	$Explabel.text = "Exp: " + str(JogoScript.experiencia)
	$Moneylabel.text = "Coin: " + str(JogoScript.dinheiro)
	$Contadorlabel.text = str(JogoScript.contador) + "/10"
	$rebirthlabel.text = "Rebirth: " + str(JogoScript.rebirth)
	$nivellebal.text = "Lvl: " + str(JogoScript.nivel)

	# Atualiza a barra de experiência
	barraexp.max_value = JogoScript.maxexp
	barraexp.value = JogoScript.experiencia

	if JogoScript.energia <= 0:
		$drinkButton.show()
	else:
		$drinkButton.hide()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		JogoScript.click()
		barraC.value += 1
		barraE.value -= 1
		atualizar_ui()
		$inactivity.start()

	if barraC.value == 10 or JogoScript.energia == 0:
		barraC.value = 0

func _on_loja_pressed():
	get_tree().change_scene_to_file("res://cenas/loja.tscn")

func _on_inactivity_timeout() -> void:
	get_tree().change_scene_to_file("res://cenas/game_over.tscn")

func _on_drink_button_pressed() -> void:
	JogoScript.energia = 100
	barraE.value = 100
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
