extends Node

var contador = 0
var dinheiro = 0
var energia = 100
var experiencia = 0  
var nivel = 1
var rebirth = 0
var maxexp = 200
var moddin = 1
var modexp = 1

func _ready():
	update_ui()

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed: 
			click()  

func click():
	if energia == 0:
		return

	contador += 1
	energia -= 1

	if experiencia >= maxexp:  # Usando experiencia em vez de exp
		experiencia = 0
		nivel += 1
		maxexp *= 2

	if contador >= 10:
		dinheiro += 100 * moddin
		experiencia += 100 * modexp  # Usando experiencia em vez de exp
		contador = 0

	if nivel % 3 == 0 and nivel != 0:
		rebirth += 1
		nivel = 0
		dinheiro = 0
		experiencia = 0  # Usando experiencia em vez de exp
		maxexp = 200
		moddin += 1
		modexp += 1

	update_ui()

func rec_energia():
	if dinheiro >= 200:
		dinheiro -= 200
		energia += 10

	update_ui()

func update_ui():
	$energylabel.text = "Energia: " + str(energia)
	$Explabel.text = "Exp: "+ str(experiencia)  # Usando experiencia em vez de exp
	$Moneylabel.text = "Coin: "+str(dinheiro)
	$Contadorlabel.text = "CLick: "+str(contador)
	$rebirthlabel.text = "Rebirth: "+str(rebirth)
	$nivellebal.text = "Lvl: "+ str(nivel)
