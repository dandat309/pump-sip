extends Node2D

var contador := 0
var dinheiro := 0
var energia := 100
var consuenergia := 1
var experiencia := 0
var nivel := 1
var rebirth := 0
var maxexp := 200
var moddin := 1
var modexp := 1

# Referências de UI
var energia_label
var exp_label
var money_label
var contador_label
var rebirth_label
var nivel_label

func click():
	if energia <= 0:
		return

	contador += 1
	energia -= consuenergia

	if contador >= 10:
		dinheiro += 100 * moddin
		experiencia += 100 * modexp
		contador = 0

	if experiencia >= maxexp:
		experiencia = 0
		nivel += 1
		maxexp *= 2

		# Rebirth se aplica apenas uma vez por múltiplo de 3
		if nivel % 3 == 0:
			rebirth += 1
			nivel = 1
			dinheiro = 0
			experiencia = 0
			maxexp = 200
			moddin += 1
			modexp += 1

func rec_energia():
	if dinheiro >= 200:
		dinheiro -= 200
		energia += 10

func _ready():
	# Inicializa referências aos nós da interface
	energia_label = $Energia
	exp_label = $Explabel
	money_label = $Moneylabel
	contador_label = $Contadorlabel
	rebirth_label = $rebirthlabel
	nivel_label = $nivellabel

	atualizar_ui()

func atualizar_ui():
	energia_label.text = "Energia: " + str(energia)
	exp_label.text = "Exp: " + str(experiencia)
	money_label.text = "Coin: " + str(dinheiro)
	contador_label.text = "Click: " + str(contador)
	rebirth_label.text = "Rebirth: " + str(rebirth)
	nivel_label.text = "Lvl: " + str(nivel)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		click()
		atualizar_ui()

func _on_loja_pressed():
	get_tree().change_scene_to_file("res://cenas/loja.tscn")
