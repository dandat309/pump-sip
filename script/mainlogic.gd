extends Node


var contador = 0
var dinheiro = 0
var energia = 100
var consuenergia = 1
var experiencia = 0
var nivel = 1
var maxlvl = 3
var rebirth = 0
var maxexp = 200
var moddin = 1
var modexp = 1
var max_contador = 10
var ganhaexp = 100


func get_totalexp() -> int:
	return ganhaexp * modexp

func _process(_delta: float) -> void:
	print(energia)

func click():
	if energia == 0:
		return

	contador += 1
	energia -= consuenergia
	
	if experiencia >= maxexp:
		experiencia = 0
		nivel += 1
		maxexp *= 2

	if contador >= 10:
		dinheiro += 100 * moddin
		experiencia += get_totalexp()
		contador = 0



func rec_energia():
	if dinheiro >= 200:
		dinheiro -= 200
		energia += 10
		if energia > 100:
			energia = 100


func gastar_dinheiro(valor):
	if dinheiro >= valor:
		dinheiro -= valor
		return true
	return false

func usar_whey():
	modexp = 5

func usar_creatina():
	modexp = 10
	

func reset_efeitos():
	modexp = 1
	consuenergia = 1
	

	
