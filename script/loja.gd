extends Node2D
@onready var backloja = preload("res://cenas/loja.tscn")
signal fechar_loja
@onready var botao_fechar = $TextureRect/voltar
func _ready():
	botao_fechar.pressed.connect(_on_botao_fechar_pressed)
	
	
func _on_botao_fechar_pressed():
	emit_signal("fechar_loja")
	

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





func atualizar_ui() -> void:
	print(JogoScript.dinheiro)
	
