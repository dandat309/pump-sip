extends Node2D

var save = "user://arquivo.save"
var tempo_restante = 0.0
var efeito_ativo = false
var backloja = preload("res://cenas/loja.tscn")
var ImageScene = preload("res://cenas/cena_imagem.tscn")
var can_spawn := true
var can_spawnback := true
var next_number := 1
var experiencia_anterior := -1
@onready var water_spray = $WaterSpray
@onready var barraC = %BarraClique
@onready var barraE = %energibar
@onready var barraexp = %barraexp

func _ready():
	barraE.value = JogoScript.energia
	barraC.value = JogoScript.contador
	barraexp.value = JogoScript.experiencia
	randomize()
	load_data()
	atualizar_ui()

func atualizar_ui():
	$energylabel.text = "Energia: " + str(JogoScript.energia)
	$Explabel.text = "Exp: " + str(JogoScript.experiencia)
	$Moneylabel.text = "Coin: " + str(JogoScript.dinheiro)
	$Contadorlabel.text = str(JogoScript.contador) + "/10"
	$rebirthlabel.text = "Rebirth: " + str(JogoScript.rebirth)
	$nivellebal.text = "Lvl: " + str(JogoScript.nivel)
	$REB.text = "REBIRTH"
	


	
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
		_save()
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
				spawn_image()
			atualizar_ui()
			$inactivity.start()
			if barraC.value == 10 or JogoScript.energia == 0:
				barraC.value = 0

func spawn_image():
	if not can_spawn:
		return  

	can_spawn = false

	await get_tree().create_timer(0.5).timeout  

	var instance = ImageScene.instantiate()
	add_child(instance)

	# Posição aleatória na tela
	var screen_size = get_viewport().get_visible_rect().size
	instance.position = Vector2(
		randi() % int(screen_size.x / 2),
		randi() % int(screen_size.y / 2)
	)

	
	instance.set_number(next_number)
	next_number = JogoScript.get_totalexp()

	
	await get_tree().create_timer(1.5).timeout
	if instance and instance.is_inside_tree():
		instance.queue_free()

	can_spawn = true

func _on_loja_pressed():
	if not can_spawnback:
		return  
	can_spawn = false
	
	await get_tree().create_timer(0.5).timeout  

	var instance = backloja.instantiate()
	add_child(instance)

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
	if JogoScript.nivel % JogoScript.maxlvl == 0 and JogoScript.nivel != 0:
		JogoScript.rebirth  += 1
		JogoScript.nivel = 0
		JogoScript.maxlvl += 5
		JogoScript.dinheiro = 0
		JogoScript.experiencia  = 0
		JogoScript.maxexp = 200
		JogoScript.moddin += 1
		JogoScript.modexp += 1
		
func _save():
	var file = FileAccess.open(save, FileAccess.WRITE)
	file.store_var(JogoScript.dinheiro)
	file.store_var(JogoScript.experiencia)
	file.store_var(JogoScript.nivel)
	file.store_var(JogoScript.rebirth)
	file.store_var(JogoScript.energia)
	file.store_var(JogoScript.maxexp)
	file.store_var(JogoScript.maxlvl)
	
func load_data():
	if FileAccess.file_exists(save):
		var file = FileAccess.open(save, FileAccess.READ)
		JogoScript.dinheiro = file.get_var(JogoScript.dinheiro)
		JogoScript.maxexp = file.get_var(JogoScript.maxexp)
		JogoScript.maxlvl = file.get_var(JogoScript.maxlvl)
		JogoScript.experiencia = file.get_var(JogoScript.experiencia)
		JogoScript.nivel =file.get_var(JogoScript.nivel)
		JogoScript.rebirth =file.get_var(JogoScript.rebirth)

	else:
		print("nada salvo")
		JogoScript.dinheiro = JogoScript.dinheiro
		JogoScript.experiencia = JogoScript.experiencia
		JogoScript.nivel = JogoScript.nivel
		JogoScript.rebirth = JogoScript.rebirth
