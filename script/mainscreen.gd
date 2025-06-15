extends Node2D


var tempo_restante = 0.0
var efeito_ativo = false
var backloja = preload("res://cenas/loja.tscn")
var can_spawn := true
var can_spawnback := true
var next_number := 1
var experiencia_anterior := -1
@onready var water_spray = $WaterSpray
@onready var barraC = %BarraClique
@onready var barraE = %energibar
@onready var barraexp = %barraexp
var instancia
var ganhadin
func _ready():
	barraE.value = JogoScript.energia
	barraC.value = JogoScript.contador
	barraexp.value = JogoScript.experiencia
	carregar_jogo()
	
	
	atualizar_ui()
	
func animaDin():
	$Ganhodin.show()
	var GShow = create_tween()
	GShow.parallel().tween_property($Ganhodin, "position:y", 300, 2).set_ease(Tween.EASE_OUT)
	GShow.parallel().tween_property($Ganhodin, "modulate:a", 0, 2)

func atualizar_ui():
	$energylabel.text = "Energia: " + str(JogoScript.energia)
	$Ganhodin.text = str(JogoScript.ganhardin)
	$Moneylabel.text = "Coin: " + str(JogoScript.dinheiro)
	$Contadorlabel.text = str(JogoScript.contador) + "/10"
	$rebirthlabel.text = "Rebirth: " + str(JogoScript.rebirth)
	$nivellebal.text = "Lvl: " + str(JogoScript.nivel)
	$REB.text = "REBIRTH"

	
	
	if JogoScript.contador >= 9:
		animaDin()
	else: 
		$Ganhodin.hide()
	
	barraexp.max_value = JogoScript.maxexp
	barraexp.value = JogoScript.experiencia
	if JogoScript.nivel == JogoScript.maxlvl:
		$REB.show()
		$rebirthbut.show()
		$inactivity.stop()
	else:
		$REB.hide()
		$rebirthbut.hide()
	if JogoScript.energia <= 0:
		$drinkButton.show()
		$player.stop()
	else:
		$drinkButton.hide()


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		salvar_jogo()
		if JogoScript.nivel < JogoScript.maxlvl: 
			JogoScript.click()
			barraC.value += 1
			barraE.value -= 1
			$player.play("flexao")
			water_spray.global_position = event.position
			water_spray.emitting = false  # para reiniciar emissão
			water_spray.emitting = true   # dispara emissão
			if JogoScript.experiencia != experiencia_anterior:
				experiencia_anterior = JogoScript.get_totalexp()
			atualizar_ui()
			$inactivity.start()
			if barraC.value == 10 or JogoScript.energia == 0:
				barraC.value = 0

func _on_loja_pressed():
	animaTween()
	

func _on_inactivity_timeout() -> void:
	get_tree().change_scene_to_file("res://cenas/game_over.tscn")

func _on_drink_button_pressed() -> void:
	JogoScript.energia = 100
	barraE.value = 100
	atualizar_ui()
	$inactivity.start()
	$drinkButton.hide()
	$anima.play("beber")
	

func _on_anima_animation_finished():
	$anima.stop()
	$player.stop()
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

func rebirt():
	if JogoScript.nivel == JogoScript.maxlvl and JogoScript.nivel != 0:
		JogoScript.rebirth  += 1
		JogoScript.nivel = 0
		JogoScript.maxlvl += 5
		JogoScript.dinheiro = 0
		JogoScript.experiencia  = 0
		JogoScript.maxexp = 200
		JogoScript.moddin += 1
		JogoScript.modexp += 1
		

func salvar_jogo():
	var dados = {
		"dinheiro": JogoScript.dinheiro,
		"maxexp": JogoScript.maxexp,
		"maxlvl": JogoScript.maxlvl,
		"exp": JogoScript.experiencia,
		"lvl": JogoScript.nivel,
		"rebirth": JogoScript.rebirth
		}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(dados))
	file.close()

func carregar_jogo():
	if FileAccess.file_exists("user://save.json"):
		var file = FileAccess.open("user://save.json", FileAccess.READ)
		var dados = JSON.parse_string(file.get_as_text())
		if typeof(dados) == TYPE_DICTIONARY:
			JogoScript.dinheiro = dados["dinheiro"]
			JogoScript.maxexp = dados["maxexp"]
			JogoScript.maxlvl = dados["maxlvl"]
			JogoScript.nivel = dados["lvl"]
			JogoScript.experiencia = dados["exp"]
			JogoScript.rebirth = dados["rebirth"]

func animaTween():
	if instancia == null:
		instancia = backloja.instantiate()
		add_child(instancia)
		instancia.fechar_loja.connect(_on_fechar_loja)
	var open = create_tween()
	open.tween_property(instancia, "position", Vector2(0, -530), 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	
	
func _on_fechar_loja():
	var tween = create_tween()
	tween.tween_property(instancia, "position", Vector2(0, 530), 0.7).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
