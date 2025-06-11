extends Node

var dinheiro = 0
var modexp = 1
var energia_consumo = 1

func gastar_dinheiro(valor):
	if dinheiro >= valor:
		dinheiro -= valor
		return true
	return false

func usar_whey():
	modexp = 2

func usar_creatina():
	modexp = 2
	energia_consumo = 2

func reset_efeitos():
	modexp = 1
	energia_consumo = 1
